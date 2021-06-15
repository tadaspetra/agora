import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:creatorstudio/config/app_id.dart';
import 'package:creatorstudio/domain/host/models/host_call_model.dart';
import 'package:creatorstudio/domain/rtc/rtc_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hostNotifier = StateNotifierProvider.autoDispose<HostNotifier, HostCall>((ref) {
  return HostNotifier(ref.read);
});

class HostNotifier extends StateNotifier<HostCall> {
  final Reader read;

  HostNotifier(this.read) : super(HostCall()) {
    _initializeEngine();
  }

  Future<void> _initializeEngine() async {
    state = state.copyWith(engine: await RtcEngine.createWithConfig(RtcEngineConfig(appId)));
  }

  Future<void> joinCall({required String channel}) async {
    read(rtcRepoProvider).joinCall(state.engine!, channel);
  }
}
