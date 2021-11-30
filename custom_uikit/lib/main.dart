import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "<-insert app id->",
      channelName: "test",
    ),
    enabledPermission: [
      Permission.camera,
      Permission.microphone,
    ],
  );

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
                videoRenderMode: VideoRenderMode.Hidden,
              ),
              AgoraVideoButtons(
                client: client,
                autoHideButtons: true,
                autoHideButtonTime: 3,
                verticalButtonPadding: 30,
                enabledButtons: const [
                  BuiltInButtons.toggleMic,
                  BuiltInButtons.callEnd,
                ],
                disconnectButtonChild: Container(
                  child: const Icon(Icons.call_end, color: Colors.white, size: 35),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  padding: const EdgeInsets.all(10.0),
                ),
                muteButtonChild: Container(
                  child: const Icon(Icons.mic, color: Colors.white, size: 35),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.4)),
                  padding: const EdgeInsets.all(10.0),
                ),
                extraButtons: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        height: 35,
                        width: 35,
                      ),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.4)),
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(left: 20),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: const Icon(Icons.people, color: Colors.white, size: 35),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.4)),
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(left: 40),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 35,
                    ),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.4)),
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.only(left: 20, top: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
