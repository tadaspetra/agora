import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:creatorstudio/controllers/director_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final rtcRepoProvider = Provider<RtcRepo>((ref) => RtcRepo(ref.read));

class RtcRepo {
  Reader read;
  RtcRepo(this.read);

  Future<void> joinCall({required RtcEngine engine, required String channel, RtcEngineEventHandler? eventHandler}) async {
    await [Permission.camera, Permission.microphone].request();
    engine.setEventHandler(eventHandler ??
        RtcEngineEventHandler(
          error: (code) {},
          joinChannelSuccess: (channel, uid, elapsed) {
            print("PARTICIPANT");
          },
          leaveChannel: (stats) {},
          userJoined: (uid, elapsed) {},
          userOffline: (uid, reason) {},
          streamMessage: (_, __, message) {
            if (message == "mute " + read(directorController).localUid.toString()) {
              engine.muteLocalAudioStream(true);
              read(directorController.notifier).toggleLocalAudio();
            }
          },
          streamMessageError: (_, __, error, ___, ____) {
            final String info = "here is the error $error";
            print(info);
          },
        ));
    engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    engine.setClientRole(ClientRole.Broadcaster);
    engine.joinChannel(null, channel, null, 0);
  }

  Future<void> joinCallAsDirector(RtcEngine engine, String channel) async {
    joinCall(
      engine: engine,
      channel: channel,
      eventHandler: RtcEngineEventHandler(
        error: (code) {},
        joinChannelSuccess: (channel, uid, elapsed) {
          print("DIRECTOR");
        },
        leaveChannel: (stats) {},
        userJoined: (uid, elapsed) {},
        userOffline: (uid, reason) {},
      ),
    );
  }
  //rtm stuff
}
