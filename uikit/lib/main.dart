import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:uikit/app_id.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(appId: appId, channelName: "test"),
    enabledPermission: [
      Permission.microphone,
      Permission.camera,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Stack(
          children: [
            AgoraVideoViewer(
              client: client,
              layoutType: Layout.floating,
            ),
            AgoraVideoButtons(client: client),
          ],
        ),
      ),
    );
  }
}
