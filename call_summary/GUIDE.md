---
title: Summarize your Video Call with Gemini
description: Build an app that transcribes your video call, and provides a summary once the call is over.
---

AI is taking over the world. Resistance is futile. So, in this article, we're going to combine AI with Agora and build an app that summarizes the call you just had.

![Screenshots of the app we will build](images/call_summary.png)

## What you will need
1. Flutter
2. Agora Speech-to-Text Server (Can use [this example server](https://github.com/tadaspetra/agora-server))
3. Gemini API Key

Our starting point is going to be a simple video call app built with Agora. If you are not familiar with Agora, we have built a full course covering all the fundamentals. 

[Here is the starter code](https://github.com/tadaspetra/agora/tree/main/call_summary/starter-app) if you want to follow along.

The starter code has a landing screen with only one button that invites you to join a call. This call happens on a single channel called `test` (it's a demo, okay). Within the call screen, you have the remote users video, your local video, and an end call button. Using the event handlers we add and remove the users into the view.

If any part of the previous paragraph didn't make sense, please take a look at the course or the [quickstart on the Agora documentation](https://docs.agora.io/en/video-calling/get-started/get-started-sdk?platform=flutter).

## Speech to Text
Agora has a product called Real Time Transcription that you can connect to in order to start transcribing the call of a specific channel.

Real Time Transcription is a RESTful API which connects to your call, and starts transcribing the audio that is being spoken. This transcription is written to a cloud provider, and can be accessed live within the call. 

### Backend
![diagram of how the video call transcription works](images/backend-with-ai.png)
The implementation of Real Time Transcription should be hosted on your own business server. The API call requires your Agora App ID, and sending it from your app over the network is not secure.

We will be using [this server as our backend](https://github.com/tadaspetra/agora-server). There are two endpoints that we will use from this server.

#### Start Real Time Transcription
```
/start-transcribing/<--Channel Name-->
```

A successful response should contain the Task Id and the Builder Token which need to be saved and used to stop the transcription.

```
{taskId: <--Task ID Value-->, builderToken: <--Builder Token Value-->}
```
#### Stop Real Time Transcription
```
/stop-transcribing/<--Channel Name-->/<--Task ID-->/<--Builder Token-->
```


## Start Transcription within the Call
To make a network call from your Flutter application, you can use the `http` package. Make sure you are using the same App Id on both the app and on the backend server. Then call your API to start the transcribing. 

If everything worked properly you should receive back a Task ID and a Builder Token. Save these, because they will be needed to stop the transcription.

```dart
Future<void> startTranscription({required String channelName}) async {
  final response = await post(
    Uri.parse('$serverUrl/start-transcribing/$channelName'),
  );

  if (response.statusCode == 200) {
    print('Transcription Started');
    taskId = jsonDecode(response.body)['taskId'];
    builderToken = jsonDecode(response.body)['builderToken'];
  } else {
    print('Couldn\'t start the transcription : ${response.statusCode}');
  }
}
```

We will call this function right after our join call method.

When the transcription is started successfully, it acts as if another user has joined the call. It's not a real user, but it does have it's own uid which is defined within you backend server. If you are using the [server I linked above](https://github.com/tadaspetra/agora-server), the UID is `101`. You can exclude this from the remote users list in the `onUserJoined` event.

```dart
onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
  if (remoteUid == 101) return;

  setState(() {
    _remoteUsers.add(remoteUid);
  });
}
```
## End Transcription
To end the transcription, we use a similar function to starting, except we need to pass the Task ID and the Builder Token to the API call.

```dart
Future<void> stopTranscription() async {
  final response = await post(
    Uri.parse('$serverUrl/stop-transcribing/$taskId/$builderToken'),
  );
  if (response.statusCode == 200) {
    print('Transcription Stopped');
  } else {
    print('Couldn\'t stop the transcription : ${response.statusCode}');
  }
}
```

We will call this method in the `dispose`, right before we leave the channel and release the engine resource.
## Retrieve the Transcription
You can get access to the transcription through the `onStreamMessage` event in the event handler. 

```dart
onStreamMessage: (RtcConnection connection, int uid, int streamId,
    Uint8List message, int messageType, int messageSize) {
  print(message);
}
```

You will notice the code above will print out a bunch of numbers that probably don't mean anything to you unless you are an all-knowing AI. To decode we will need to use protobuf and create a readable object from this.
## Decode the Transcription
To decode the message, we will use a Protocol Buffer (also refered to as protobuf). A protocol buffer is a language and platform neutral generator for serializing data. In this case we will serialize the random looking numbers into an object called `Message`. 

You first need to create a `.proto` file with the following content. I will create this file in it's own folder: `lib/protobuf/file.proto`.

```
syntax = "proto3";

package call_summary;

message Message {
  int32 vendor = 1;
  int32 version = 2;
  int32 seqnum = 3;
  int32 uid = 4;
  int32 flag = 5;
  int64 time = 6;
  int32 lang = 7;
  int32 starttime = 8;
  int32 offtime = 9;
  repeated Word words = 10;
}
message Word {
  string text = 1;
  int32 start_ms = 2;
  int32 duration_ms = 3;
  bool is_final = 4;
  double confidence = 5;
}
```

This is the input file for the generator to create our `Message` object. 

In order to use protobuf you need to install the protobuf compiler to your computer. You can find the [download for it here](https://protobuf.dev/downloads/), or if you are using mac, you can install it using `brew install protobuf`.

You will also need to install the `protobuf` dart package within your project. You can do that using `flutter pub add protobuf`.

Now run the following command in your terminal and you should see 4 files get generated in the same `lib/protobuf` folder.

```
protoc --proto_path= --dart_out=. lib/protobuf/file.proto  
```

Now we can use the new `Message` object to retrieve our transcription in english. This object contains a `words` array, with the sentences being spoken. Using the `isFinal` variable we trigger a print statement whenever the sentence is finished.

```dart
onStreamMessage: (RtcConnection connection, int uid, int streamId,
    Uint8List message, int messageType, int messageSize) {
  Message text = Message.fromBuffer(message);
  if (text.words[0].isFinal) {
    print(text.words[0].text);
  }
},
```

## Save the Transcription
We have covered the transcription part, now we need to get the transcribed text, and prompt an AI to give us a summary. The simplest way to do this is to just concatenate a long string of the responses. There are definitely more sophisticated ways to do it, but for this demo it is good enough.

We can hold a string called `transcription` and add the text as it is finalized.

```dart
 onStreamMessage: (RtcConnection connection, int uid, int streamId,
	Uint8List message, int messageType, int messageSize) {
  Message text = Message.fromBuffer(message);
  if (text.words[0].isFinal) {
	print(text.words[0].text);
	transcription += text.words[0].text;
  }
},
```

## Get Summary
Back in the `main.dart` we can connect to Gemini using our apiKey. Then we can prompt it to summarize the video call. Then when you receive this response you can call `setState` and update the `summary` variable to see your changes reflected on the main page.

> As I was testing this app I noticed that the response likes to mention the transcript I pass in. Because of this, I added some extra prompt to not mention the transcript.

This function is passed to the video call file, and then triggered when the call is over.

```dart
late final GenerativeModel model;

@override
void initState() {
  super.initState();
  model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
}

void retrieveSummary(String transcription) async {
  final content = [
    Content.text(
      'This is a transcript of a video call that occurred. Please summarize this call in a few sentences. Dont talk about the transcript just give the summary. This is the transcript: $transcription',
    ),
  ];
  final response = await model.generateContent(content);
  setState(() {
    summary = response.text ?? '';
  });
}
```

## Done
![diagram of how the video call, transcription and AI all work together](images/backend-with-ai.png)

This is a simplified example of how you can utilize the Agora SDK and AI to make your apps even more powerful. 

You can find the [code here](https://github.com/tadaspetra/agora/tree/main/call_summary). And learn more about all the [Agora SDKs here](https://www.agora.io/en/).

Thank you for reading!


