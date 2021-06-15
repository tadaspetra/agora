import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final rtcRepoProvider = Provider<RtcRepo>((ref) => RtcRepo(ref.read));

class RtcRepo {
  Reader read;
  RtcRepo(this.read);

  Future<void> joinCall(RtcEngine engine, String channel) async {
    await [Permission.camera, Permission.microphone].request();
    engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {},
      joinChannelSuccess: (channel, uid, elapsed) {
        print("TADAS");
      },
      leaveChannel: (stats) {},
      userJoined: (uid, elapsed) {},
      userOffline: (uid, reason) {},
    ));
    engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    engine.setClientRole(ClientRole.Broadcaster);
    engine.joinChannel(null, channel, null, 0);
  }
}
