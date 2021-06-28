import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:creatorstudio/models/director_model.dart';
import 'package:creatorstudio/utils/appId.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../rtc_repo.dart';

final directorController = StateNotifierProvider.autoDispose<DirectorController, DirectorModel>((ref) {
  return DirectorController(ref.read);
});

class DirectorController extends StateNotifier<DirectorModel> {
  final Reader read;

  DirectorController(this.read) : super(DirectorModel());

  Future<void> _initializeEngine() async {
    RtcEngine _engine = await RtcEngine.createWithConfig(RtcEngineConfig(appId));
    state = DirectorModel(engine: _engine);
  }

  Future<void> joinCall({required String channel}) async {
    await _initializeEngine();
    state = state.copyWith(streamId: await state.engine?.createDataStream(false, false));
    read(rtcRepoProvider).joinCallAsDirector(state.engine!, channel);
  }

  Future<void> toggleLocalAudio() async {
    state = state.copyWith(localMuted: true);
  }

  Future<void> leaveCall() async {
    state.engine?.leaveChannel();
    state.engine?.destroy();
  }

  Future<void> toggleUserAudio({required int uid}) async {}
  Future<void> toggleUserVideo({required int uid}) async {}
  Future<void> addUserToView({required int uid}) async {}
}
