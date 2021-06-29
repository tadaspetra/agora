import 'package:agora_rtc_engine/rtc_engine.dart';

import 'package:creatorstudio/models/user.dart';

class DirectorModel {
  RtcEngine? engine;
  Set<AgoraUser> activeUsers;
  int? streamId;
  AgoraUser? localUser;

  DirectorModel({
    this.engine,
    this.activeUsers = const {},
    this.streamId,
    this.localUser,
  });

  DirectorModel copyWith({
    RtcEngine? engine,
    Set<AgoraUser>? activeUsers,
    int? streamId,
    AgoraUser? localUser,
  }) {
    return DirectorModel(
      engine: engine ?? this.engine,
      activeUsers: activeUsers ?? this.activeUsers,
      streamId: streamId ?? this.streamId,
      localUser: localUser ?? this.localUser,
    );
  }
}
