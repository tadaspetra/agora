import 'dart:async';
import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import 'package:permission_handler/permission_handler.dart';

const appId = "7f4e31eb26824a8189d2dae24b597a86";
const token =
    "0067f4e31eb26824a8189d2dae24b597a86IACYJb6hgJzJSZwB2Z9faKF8P85iEMpg1n+Cvx4qeANpYtzDPrsAAAAAEAALtir+tmOMYAEAAQC2Y4xg";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _localUserJoined = false;
  bool _showStats = false;
  int _remoteUid;
  RtcStats _stats = RtcStats();

  @override
  void initState() {
    super.initState();
    initForAgora();
  }

  Future<void> initForAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    // create the engine for communicating with agora
    RtcEngine engine = await RtcEngine.create(appId);

    // set up event handling for the engine
    engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        print('$uid successfully joined channel: $channel ');
        setState(() {
          _localUserJoined = true;
        });
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
      rtcStats: (stats) {
        //updates every two seconds
        if (_showStats) {
          _stats = stats;
          setState(() {});
        }
      },
    ));
    // enable video
    await engine.enableVideo();

    await engine.joinChannel(token, 'firstchannel', null, 0);
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter example app'),
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
        floatingActionButton: _showStats
            ? _statsView()
            : ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showStats = true;
                  });
                },
                child: Text("Show Stats"),
              ),
      ),
    );
  }

  Widget _statsView() {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: _stats.cpuAppUsage == null
          ? CircularProgressIndicator()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("CPU Usage: " + _stats.cpuAppUsage.toString()),
                Text("Duration (seconds): " + _stats.totalDuration.toString()),
                Text("People on call: " + _stats.users.toString()),
                ElevatedButton(
                  onPressed: () {
                    _showStats = false;
                    _stats.cpuAppUsage = null;
                    setState(() {});
                  },
                  child: Text("Close"),
                )
              ],
            ),
    );
  }

  // current user video
  Widget _renderLocalPreview() {
    if (_localUserJoined) {
      return RtcLocalView.SurfaceView();
    } else {
      return Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
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
