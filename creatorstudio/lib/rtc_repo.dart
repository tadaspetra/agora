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
          streamMessage: (_, __, message) {},
          streamMessageError: (_, __, error, ___, ____) {
            final String info = "here is the error $error";
            print(info);
          },
        ));
    engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    engine.setClientRole(ClientRole.Broadcaster);
    engine.enableVideo();
    engine.joinChannel(null, channel, null, 0);
  }

  Future<void> joinCallAsDirector(RtcEngine engine, String channel) async {
    await [Permission.camera, Permission.microphone].request();
    engine.setEventHandler(
      RtcEngineEventHandler(
          error: (code) {},
          joinChannelSuccess: (channel, uid, elapsed) {
            print("DIRECTOR");
          },
          leaveChannel: (stats) {},
          userJoined: (uid, elapsed) {
            read(directorController.notifier).addUserToLobby(uid: uid);
          },
          userOffline: (uid, reason) {
            read(directorController.notifier).removeUser(uid: uid);
          },
          remoteAudioStateChanged: (uid, state, reason, elapsed) {
            if ((state == AudioRemoteState.Decoding) && (reason == AudioRemoteStateReason.RemoteUnmuted)) {
              read(directorController.notifier).updateUserAudio(uid: uid, muted: false);
            } else if ((state == AudioRemoteState.Stopped) && (reason == AudioRemoteStateReason.RemoteMuted)) {
              read(directorController.notifier).updateUserAudio(uid: uid, muted: true);
            }
          },
          remoteVideoStateChanged: (uid, state, reason, elapsed) {
            if ((state == VideoRemoteState.Decoding) && (reason == VideoRemoteStateReason.RemoteUnmuted)) {
              read(directorController.notifier).updateUserVideo(uid: uid, videoDisabled: false);
            } else if ((state == VideoRemoteState.Stopped) && (reason == VideoRemoteStateReason.RemoteMuted)) {
              read(directorController.notifier).updateUserVideo(uid: uid, videoDisabled: true);
            }
          }),
    );
    engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    engine.setClientRole(ClientRole.Broadcaster);
    engine.enableVideo();
    engine.joinChannel(null, channel, null, 0);
  }
}
