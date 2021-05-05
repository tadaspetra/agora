import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import 'package:permission_handler/permission_handler.dart';

const appId = "7f4e31eb26824a8189d2dae24b597a86";
const token =
    "0067f4e31eb26824a8189d2dae24b597a86IABzGq+88FgEvMF86+MBZGpQyIYWa/FfmLeZ0UkASb6FBdzDPrsAAAAAEAALtir+zeWSYAEAAQDN5ZJg";

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _remoteUid;
  RtcEngine engine;

  @override
  void initState() {
    super.initState();
    initForAgora();
  }

  Future<void> initForAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    // create the engine for communicating with agora
    engine = await RtcEngine.createWithConfig(RtcEngineConfig(appId));
    // enable video
    await engine.enableVideo();

    engine.setChannelProfile(ChannelProfile.LiveBroadcasting);

    engine.setClientRole(ClientRole.Broadcaster);

    // set up event handling for the engine
    engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        print('$uid successfully joined channel: $channel ');
        setState(() {});
      },
      userJoined: (int uid, int elapsed) {
        print('remote user $uid joined channel');
        setState(() {
          _remoteUid = uid;
        });
      },
      userOffline: (int uid, UserOfflineReason reason) {
        print('remote user $uid left channel');
        setState(() {
          _remoteUid = null;
        });
      },
    ));

    await engine.joinChannel(token, 'firstchannel', null, 0);
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _renderRemoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 100,
              height: 100,
              child: Center(
                child: _renderLocalPreview(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // current user video
  Widget _renderLocalPreview() {
    return Transform.rotate(
      angle: 90 * pi / 180,
      child: RtcLocalView.SurfaceView(),
    );
  }

  // remote user video
  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid);
    } else {
      return Text(
        'Please wait remote user join',
        textAlign: TextAlign.center,
      );
    }
  }
}
