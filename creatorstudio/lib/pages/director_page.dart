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
  @override
  void initState() {
    context.read(directorController.notifier).joinCall(channel: widget.channelName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
      DirectorController directorNotifier = watch(directorController.notifier);
      DirectorModel directorData = watch(directorController);
      Size size = MediaQuery.of(context).size;
      return Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text("Add Stream Destination"),
                          onPressed: () {
                            throw (UnimplementedError);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SliverGrid(
              gridDelegate:
                  SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: size.width / 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
              delegate: SliverChildBuilderDelegate((BuildContext ctx, index) {
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: directorData.activeUsers.elementAt(index).videoDisabled
                                  ? Container(
                                      color: Colors.black,
                                    )
                                  : RtcRemoteView.SurfaceView(
                                      uid: directorData.activeUsers.elementAt(index).uid,
                                    ),
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black54),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => directorNotifier.toggleUserAudio(index: index),
                                    icon: Icon(Icons.mic_off),
                                    color: directorData.activeUsers.elementAt(index).muted ? Colors.red : Colors.white,
                                  ),
                                  IconButton(
                                    onPressed: () => directorNotifier.toggleUserVideo(index: index),
                                    icon: Icon(Icons.videocam_off),
                                    color: directorData.activeUsers.elementAt(index).videoDisabled ? Colors.red : Colors.white,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      throw (UnimplementedError);
                                    },
                                    icon: Icon(Icons.arrow_downward),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }, childCount: directorData.activeUsers.length),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 3,
                      indent: 80,
                      endIndent: 80,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      directorNotifier.leaveCall();
                      Navigator.pop(context);
                    },
                    child: Text("Leave Call"),
                  ),
                  directorData.isLive
                      ? ElevatedButton(
                          onPressed: () {
                            throw (UnimplementedError);
                          },
                          child: Text("End Livestream"),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            throw (UnimplementedError);
                          },
                          child: Text("Start Livestream"),
                        ),
                ],
              ),
            ),
          ],
        ),
      ));
    });
  }
}
