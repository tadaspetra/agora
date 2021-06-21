import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:creatorstudio/domain/host/models/host_call_model.dart';
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
        ));
    engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    engine.setClientRole(ClientRole.Audience);
    engine.joinChannel(null, channel, null, 0);
  }

  Future<void> joinCallAsDirector(HostCall hostCall, String channel) async {
    joinCall(
      engine: hostCall.engine!,
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
