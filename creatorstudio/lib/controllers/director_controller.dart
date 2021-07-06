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
    try {
      AgoraUser _temp = state.activeUsers.singleWhere((element) => element.uid == uid);
      Set<AgoraUser> _tempSet = state.activeUsers;
      _tempSet.remove(_temp);
      _tempSet.add(_temp.copyWith(muted: muted));
      state = state.copyWith(activeUsers: _tempSet);
    } catch (e) {
      return;
    }
  }

  Future<void> toggleUserVideo({required int index}) async {
    state.engine?.sendStreamMessage(state.streamId!, Message().sendDisableVideoMessage(uid: state.activeUsers.elementAt(index).uid));
  }

  Future<void> updateUserVideo({required int uid, required bool videoDisabled}) async {
    try {
      AgoraUser _temp = state.activeUsers.singleWhere((element) => element.uid == uid);
      Set<AgoraUser> _tempSet = state.activeUsers;
      _tempSet.remove(_temp);
      _tempSet.add(_temp.copyWith(videoDisabled: videoDisabled));
      state = state.copyWith(activeUsers: _tempSet);
    } catch (e) {
      return;
    }
  }

  Future<void> addUserToLobby({required int uid}) async {
    state = state.copyWith(lobbyUsers: {
      ...state.lobbyUsers,
      AgoraUser(
        uid: uid,
      )
    });
    state.engine?.sendStreamMessage(state.streamId!, Message().sendMuteMessage(uid: uid));
    state.engine?.sendStreamMessage(state.streamId!, Message().sendActiveUsers(activeUsers: state.activeUsers));
  }

  Future<void> promoteToActiveUser({required int uid}) async {
    Set<AgoraUser> _tempLobby = state.lobbyUsers;
    for (int i = 0; i < _tempLobby.length; i++) {
      if (_tempLobby.elementAt(i).uid == uid) {
        _tempLobby.remove(_tempLobby.elementAt(i));
      }
    }
    state = state.copyWith(activeUsers: {
      ...state.activeUsers,
      AgoraUser(
        uid: uid,
      )
    }, lobbyUsers: _tempLobby);
    state.engine?.sendStreamMessage(state.streamId!, Message().sendMuteMessage(uid: uid));
    state.engine?.sendStreamMessage(state.streamId!, Message().sendDisableVideoMessage(uid: uid));
    state.engine?.sendStreamMessage(state.streamId!, Message().sendActiveUsers(activeUsers: state.activeUsers));
  }

  Future<void> demoteToLobbyUser({required int uid}) async {
    Set<AgoraUser> _temp = state.activeUsers;
    bool wasMuted = false;
    bool wasVideoMuted = false;
    for (int i = 0; i < _temp.length; i++) {
      if (_temp.elementAt(i).uid == uid) {
        if (_temp.elementAt(i).muted) {
          wasMuted = true;
        }
        if (_temp.elementAt(i).videoDisabled) {
          wasVideoMuted = true;
        }
        _temp.remove(_temp.elementAt(i));
      }
    }
    state = state.copyWith(activeUsers: _temp, lobbyUsers: {
      ...state.lobbyUsers,
      AgoraUser(
        uid: uid,
      )
    });
    if (!wasMuted) {
      state.engine?.sendStreamMessage(state.streamId!, Message().sendMuteMessage(uid: uid));
    }
    if (!wasVideoMuted) {
      state.engine?.sendStreamMessage(state.streamId!, Message().sendDisableVideoMessage(uid: uid));
    }

    state.engine?.sendStreamMessage(state.streamId!, Message().sendActiveUsers(activeUsers: state.activeUsers));
  }

  Future<void> removeUser({required int uid}) async {
    Set<AgoraUser> _temp = state.activeUsers;
    Set<AgoraUser> _tempLobby = state.lobbyUsers;
    for (int i = 0; i < _temp.length; i++) {
      if (_temp.elementAt(i).uid == uid) {
        _temp.remove(_temp.elementAt(i));
      }
    }
    for (int i = 0; i < _tempLobby.length; i++) {
      if (_tempLobby.elementAt(i).uid == uid) {
        _tempLobby.remove(_tempLobby.elementAt(i));
      }
    }
    state = state.copyWith(activeUsers: _temp, lobbyUsers: _tempLobby);
  }

  Future<void> startStream() async {
    List<TranscodingUser> transcodingUsers = [];
    if (state.activeUsers.isEmpty) {
    } else if (state.activeUsers.length == 1) {
      transcodingUsers.add(TranscodingUser(state.activeUsers.elementAt(0).uid, 0, 0, width: 400, height: 400, zOrder: 1, alpha: 1));
    } else if (state.activeUsers.length == 2) {
      transcodingUsers.add(TranscodingUser(state.activeUsers.elementAt(0).uid, 0, 0, width: 400, height: 400, zOrder: 1, alpha: 1));
      transcodingUsers.add(TranscodingUser(state.activeUsers.elementAt(1).uid, 400, 400, width: 400, height: 400, zOrder: 1, alpha: 1));
    }

    LiveTranscoding transcoding = LiveTranscoding(
      transcodingUsers,
    );
    state.engine?.setLiveTranscoding(transcoding);
    state.engine?.addPublishStreamUrl("rtmp://a.rtmp.youtube.com/live2/6fkt-6ecx-0rhm-1gat-58zv", true);
    state = state.copyWith(isLive: true);
  }

  Future<void> endStream() async {
    state.engine?.removePublishStreamUrl("rtmp://a.rtmp.youtube.com/live2/6fkt-6ecx-0rhm-1gat-58zv");
    state = state.copyWith(isLive: false);
  }
}
