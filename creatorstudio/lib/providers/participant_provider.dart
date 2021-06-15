import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:creatorstudio/config/app_id.dart';
import 'package:creatorstudio/domain/participant/models/participant_call_model.dart';
import 'package:creatorstudio/domain/rtc/rtc_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final participantCallController = StateNotifierProvider.autoDispose((ref) {
  return ParticipantNotifier(ref.read);
});

class ParticipantNotifier extends StateNotifier<ParticipantCall> {
  final Reader read;

  ParticipantNotifier(this.read) : super(ParticipantCall()) {
    _initializeEngine();
  }

  Future<void> _initializeEngine() async {
    state = state.copyWith(engine: await RtcEngine.createWithConfig(RtcEngineConfig(appId)));
  }

  Future<void> joinCall({required String channel}) async {
    read(rtcRepoProvider).joinCall(state.engine!, channel);
  }
}
