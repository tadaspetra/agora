import 'package:agora_uikit/agora_uikit.dart';
import 'package:creatorstudio/config/app_id.dart';
import 'package:creatorstudio/domain/participant/models/participant_call_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final participantController = StateNotifierProvider.autoDispose<ParticipantController, ParticipantCall>((ref) {
  return ParticipantController(ref.read);
});

class ParticipantController extends StateNotifier<ParticipantCall> {
  final Reader read;

  ParticipantController(this.read) : super(ParticipantCall());

  Future<void> joinCall({required String channel}) async {
    state = state.copyWith(
      client: AgoraClient(
          agoraConnectionData: AgoraConnectionData(appId: appId, channelName: channel),
          enabledPermission: [Permission.camera, Permission.microphone]),
    );
  }
}
