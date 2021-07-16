import 'package:creatorstudio/controllers/director_controller.dart';
import 'package:creatorstudio/models/director_model.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
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
  String? streamUrl;

  @override
  void initState() {
    context.read(directorController.notifier).joinCall(channel: widget.channelName);
    super.initState();
  }

  Future<Widget?> streamDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 500),
          child: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              TextEditingController urlController = TextEditingController();
              TextEditingController keyController = TextEditingController();
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(hintText: "Stream URL"),
                        controller: urlController,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Stream Key"),
                        controller: keyController,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          streamUrl = urlController.text.trim() + "/" + keyController.text.trim();
                          Navigator.pop(context);
                        },
                        child: Text("Save Destination"),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
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
                        streamUrl == null
                            ? TextButton(
                                child: Text("Add Stream Destination"),
                                onPressed: () async {
                                  await streamDialog(context);
                                },
                              )
                            : TextButton(
                                onPressed: () {
                                  streamUrl = null;
                                  setState(() {});
                                },
                                child: Text("Clear Stream Destination"),
                              )
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
                                  ? Stack(children: [
                                      Container(
                                        color: Colors.black,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Video Off",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ])
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
                                      directorNotifier.demoteToLobbyUser(uid: directorData.activeUsers.elementAt(index).uid);
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
                              child: directorData.lobbyUsers.elementAt(index).videoDisabled
                                  ? Stack(children: [
                                      Container(
                                        color: Colors.black,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Video Off",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    ])
                                  : RtcRemoteView.SurfaceView(
                                      uid: directorData.lobbyUsers.elementAt(index).uid,
                                    ),
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black54),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      directorNotifier.promoteToActiveUser(uid: directorData.lobbyUsers.elementAt(index).uid);
                                    },
                                    icon: Icon(Icons.arrow_upward),
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
              }, childCount: directorData.lobbyUsers.length),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
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
                            if (streamUrl != null) {
                              directorNotifier.endStream(streamUrl!);
                            } else {
                              throw ("Invalid URL");
                            }
                          },
                          child: Text("End Livestream"),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (streamUrl != null) {
                              directorNotifier.startStream(streamUrl!);
                            } else {
                              throw ("Invalid URL");
                            }
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
