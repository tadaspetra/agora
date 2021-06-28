import 'package:creatorstudio/controllers/director_controller.dart';
import 'package:creatorstudio/models/director_model.dart';
import 'package:creatorstudio/utils/appId.dart';
import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:creatorstudio/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BroadcastPage extends StatefulWidget {
  final String channelName;

  const BroadcastPage({
    Key? key,
    required this.channelName,
  }) : super(key: key);

  @override
  _BroadcastPageState createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  final _users = <int>[];

  @override
  void initState() {
    // TODO: implement initState
    context.read(directorController.notifier).joinCall(channel: widget.channelName);
    super.initState();
  }

  @override
  void dispose() {
    // clear users
    _users.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            DirectorController directorNotifier = watch(directorController.notifier);
            DirectorModel directorData = watch(directorController);
            return Stack(
              children: <Widget>[
                _broadcastView(),
                _toolbar(directorData, directorNotifier),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _toolbar(DirectorModel directorModel, DirectorController directorController) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () => directorController.toggleLocalAudio(),
            child: Icon(
              directorModel.localMuted ? Icons.mic_off : Icons.mic,
              color: directorModel.localMuted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: directorModel.localMuted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () {
              if (directorModel.streamId != null) {
                directorModel.engine?.sendStreamMessage(directorModel.streamId!, Message().sendMuteMessage(uid: _users[0].toString()));
              }
            },
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
        ],
      ),
    );
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view row wrapper
  Widget _expandedVideoView(List<Widget> views) {
    final wrappedViews = views.map<Widget>((view) => Expanded(child: Container(child: view))).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _broadcastView() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView([views[0]])
          ],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoView([views[0]]),
            _expandedVideoView([views[1]])
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[_expandedVideoView(views.sublist(0, 2)), _expandedVideoView(views.sublist(2, 3))],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[_expandedVideoView(views.sublist(0, 2)), _expandedVideoView(views.sublist(2, 4))],
        ));
      default:
    }
    return Container();
  }

  void _onCallEnd(BuildContext context) {
    context.read(directorController.notifier).leaveCall();
    Navigator.pop(context);
  }

  // void _onToggleMute() {
  //   setState(() {
  //     muted = !muted;
  //   });
  //   _engine.muteLocalAudioStream(muted);
  // }

  // void _onSwitchCamera() {
  //   if (streamId != null) _engine.sendStreamMessage(streamId!, Message().sendMuteMessage(uid: _users[0].toString()));
  //   //_engine.switchCamera();
  // }
}
