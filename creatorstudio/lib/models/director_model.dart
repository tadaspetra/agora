import 'package:agora_rtc_engine/rtc_engine.dart';

import 'package:creatorstudio/models/user.dart';

class DirectorModel {
  RtcEngine? engine;
  Set<AgoraUser> activeUsers;
  Set<AgoraUser> lobbyUsers;
  int? streamId;
  AgoraUser? localUser;
  bool isLive;

  DirectorModel({
    this.engine,
    this.activeUsers = const {},
    this.lobbyUsers = const {},
    this.streamId,
    this.localUser,
    this.isLive = false,
  });

  DirectorModel copyWith({
    RtcEngine? engine,
    Set<AgoraUser>? activeUsers,
    Set<AgoraUser>? lobbyUsers,
    int? streamId,
    AgoraUser? localUser,
    bool? isLive,
  }) {
    return DirectorModel(
      engine: engine ?? this.engine,
      activeUsers: activeUsers ?? this.activeUsers,
      lobbyUsers: lobbyUsers ?? this.lobbyUsers,
      streamId: streamId ?? this.streamId,
      localUser: localUser ?? this.localUser,
      isLive: isLive ?? this.isLive,
    );
  }
}
