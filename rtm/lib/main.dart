import 'package:flutter/material.dart';
import 'dart:async';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:test_project/appId.dart';
import 'package:test_project/logs.dart';
import 'package:test_project/message.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _userId = TextEditingController();
  final _channelName = TextEditingController();

  AgoraRtmClient _client;
  AgoraRtmChannel _channel;
  LogController logController = LogController();

  @override
  void initState() {
    super.initState();
    _createClient();
  }

  void _createClient() async {
    _client = await AgoraRtmClient.createInstance(appId);
    _client.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      logController.addLog("Private Message from " + peerId + ": " + message.text);
    };
    _client.onConnectionStateChanged = (int state, int reason) {
      logController.addLog('Connection state changed: ' + state.toString() + ', reason: ' + reason.toString());
      if (state == 5) {
        _client.logout();
        logController.addLog('Logout.');
      }
    };
  }

  void _login(BuildContext context) async {
    String userId = _userId.text;
    if (userId.isEmpty) {
      print('Please input your user id to login.');
      return;
    }

    try {
      await _client.login(null, userId);
      logController.addLog('Login success: ' + userId);
      _joinChannel(context);
    } catch (errorCode) {
      print('Login error: ' + errorCode.toString());
    }
  }

  void _joinChannel(BuildContext context) async {
    String channelId = _channelName.text;
    if (channelId.isEmpty) {
      logController.addLog('Please input channel id to join.');
      return;
    }

    try {
      _channel = await _createChannel(channelId);
      await _channel.join();
      logController.addLog('Join channel success.');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MessageScreen(
                    client: _client,
                    channel: _channel,
                    logController: logController,
                  )));
    } catch (errorCode) {
      print('Join channel error: ' + errorCode.toString());
    }
  }

  Future<AgoraRtmChannel> _createChannel(String name) async {
    AgoraRtmChannel channel = await _client.createChannel(name);
    channel.onMemberJoined = (AgoraRtmMember member) {
      logController.addLog("Member joined: " + member.userId + ', channel: ' + member.channelId);
    };
    channel.onMemberLeft = (AgoraRtmMember member) {
      logController.addLog("Member left: " + member.userId + ', channel: ' + member.channelId);
    };
    channel.onMessageReceived = (AgoraRtmMessage message, AgoraRtmMember member) {
      logController.addLog("Public Message from " + member.userId + ": " + message.text);
    };
    return channel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Real Time Message'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(controller: _userId, decoration: InputDecoration(hintText: 'User ID')),
            TextField(controller: _channelName, decoration: InputDecoration(hintText: 'Channel')),
            OutlinedButton(child: Text('Login'), onPressed: () => _login(context)),
          ],
        ),
      ),
    );
  }
}
