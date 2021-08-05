import 'package:creatorstudio/controllers/director_controller.dart';
import 'package:creatorstudio/models/director_model.dart';
import 'package:creatorstudio/models/stream.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:circular_menu/circular_menu.dart';

class BroadcastPage extends StatefulWidget {
  final String channelName;
  final int uid;

  const BroadcastPage({
    Key? key,
    required this.channelName,
    required this.uid,
  }) : super(key: key);

  @override
  _BroadcastPageState createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastPage> {
  String? streamUrl;

  @override
  void initState() {
    context.read(directorController.notifier).joinCall(channelName: widget.channelName, uid: widget.uid);
    super.initState();
  }

  Future<dynamic> showBottomSheet(BuildContext context, Object value, DirectorController directorNotifier) {
    TextEditingController streamUrl = TextEditingController();
    TextEditingController streamKey = TextEditingController();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add Your Stream Destination",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                autofocus: true,
                controller: streamUrl,
                decoration: InputDecoration(hintText: "Stream Url"),
              ),
              TextField(
                controller: streamKey,
                decoration: InputDecoration(hintText: "Stream Key"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        directorNotifier.addPublishDestination(
                            value as StreamPlatform, streamUrl.text.trim() + "/" + streamKey.text.trim());
                        Navigator.pop(context);
                      },
                      child: Text("Add"),
                    ),
                  ],
                ),
              ),
            ],
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
        child: CircularMenu(
          alignment: Alignment.bottomRight,
          toggleButtonColor: Colors.black,
          items: [
            CircularMenuItem(
                icon: Icons.home,
                color: Colors.green,
                onTap: () {
                  setState(() {});
                }),
            CircularMenuItem(
                icon: Icons.search,
                color: Colors.blue,
                onTap: () {
                  setState(() {});
                }),
            CircularMenuItem(
              icon: Icons.settings,
              color: Colors.orange,
              onTap: () {
                setState(() {});
              },
            ),
          ],
          backgroundWidget: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PopupMenuButton(
                            itemBuilder: (context) {
                              List<PopupMenuEntry<Object>> list = [];
                              list.add(PopupMenuItem(
                                child: ListTile(leading: Icon(Icons.add), title: Text("Youtube")),
                                value: StreamPlatform.youtube,
                              ));
                              list.add(PopupMenuDivider());
                              list.add(PopupMenuItem(
                                child: ListTile(leading: Icon(Icons.add), title: Text("Twitch")),
                                value: StreamPlatform.twitch,
                              ));
                              list.add(PopupMenuDivider());
                              list.add(PopupMenuItem(
                                child: ListTile(leading: Icon(Icons.add), title: Text("Other")),
                                value: StreamPlatform.other,
                              ));
                              return list;
                            },
                            icon: Icon(Icons.add),
                            onCanceled: () {
                              print("You have canceled the menu");
                            },
                            onSelected: (value) {
                              showBottomSheet(context, value!, directorNotifier);
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          for (int i = 0; i < directorData.destinations.length; i++) Text(directorData.destinations[i].platform.toString())
                        ],
                      ),
                    )
                  ],
                ),
              ),
              if (directorData.activeUsers.isEmpty)
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text("Empty Stage"),
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
                                      onPressed: () {
                                        if (directorData.activeUsers.elementAt(index).muted) {
                                          directorNotifier.toggleUserAudio(index: index, muted: true);
                                        } else {
                                          directorNotifier.toggleUserAudio(index: index, muted: false);
                                        }
                                      },
                                      icon: Icon(Icons.mic_off),
                                      color: directorData.activeUsers.elementAt(index).muted ? Colors.red : Colors.white,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (directorData.activeUsers.elementAt(index).videoDisabled) {
                                          directorNotifier.toggleUserVideo(index: index, enable: false);
                                        } else {
                                          directorNotifier.toggleUserVideo(index: index, enable: true);
                                        }
                                      },
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
              if (directorData.lobbyUsers.isEmpty)
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text("Empty Lobby"),
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
                              directorNotifier.endStream();
                            },
                            child: Text("End Livestream"),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (directorData.destinations.isNotEmpty) {
                                directorNotifier.startStream();
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
        ),
      ));
    });
  }
}
