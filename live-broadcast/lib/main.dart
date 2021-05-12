import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';

import 'callpage.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _channelController = TextEditingController();
  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  /// The button to join channel
  Future<void> onJoin() async {
    if (_channelController.text.isNotEmpty) {
      // Wait for the permission for camera and microphone
      await _handleCameraAndMic();
      // Enter the page for live streaming and join channel using the channel name and role specified in the login page
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  // Ask for the permission for camera and microphone
  Future<void> _handleCameraAndMic() async {
    await [Permission.camera, Permission.microphone].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agora Flutter QuickStart'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: _channelController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      hintText: 'Channel name',
                    ),
                  ))
                ],
              ),
              Column(
                children: [
                  ListTile(
                    title: Text(ClientRole.Broadcaster.toString()),
                    leading: Radio(
                      value: ClientRole.Broadcaster,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(ClientRole.Audience.toString()),
                    leading: Radio(
                      value: ClientRole.Audience,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onJoin,
                        child: Text('Join'),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
