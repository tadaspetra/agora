import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:creatorstudio/message.dart';
import 'package:creatorstudio/models/director_model.dart';
import 'package:creatorstudio/models/user.dart';
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

  Future<void> leaveCall() async {
    state.engine?.leaveChannel();
    state.engine?.destroy();
  }

  Future<void> toggleUserAudio({required int index}) async {
    state.engine?.sendStreamMessage(state.streamId!, Message().sendMuteMessage(uid: state.activeUsers.elementAt(index).uid));
  }

  Future<void> updateUserAudio({required int uid, required bool muted}) async {
    AgoraUser _temp = state.activeUsers.singleWhere((element) => element.uid == uid);
    Set<AgoraUser> _tempSet = state.activeUsers;
    _tempSet.remove(_temp);
    _tempSet.add(_temp.copyWith(muted: muted));
    state = state.copyWith(activeUsers: _tempSet);
  }

  Future<void> toggleUserVideo({required int uid}) async {}

  Future<void> addUser({required int uid}) async {
    state = state.copyWith(activeUsers: {...state.activeUsers, AgoraUser(uid: uid)});
  }

  Future<void> removeUser({required int uid}) async {
    Set<AgoraUser> _temp = state.activeUsers;
    for (int i = 0; i < _temp.length; i++) {
      if (_temp.elementAt(i).uid == uid) {
        _temp.remove(_temp.elementAt(i));
      }
    }
    state = state.copyWith(activeUsers: _temp);
  }
}
