import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';

import 'package:creatorstudio/models/user.dart';

class DirectorModel {
  RtcEngine? engine;
  AgoraRtmClient? client;
  AgoraRtmChannel? channel;
  Set<AgoraUser> activeUsers;
  Set<AgoraUser> lobbyUsers;
  AgoraUser? localUser;
  bool isLive;

  DirectorModel({
    this.engine,
    this.client,
    this.channel,
    this.activeUsers = const {},
    this.lobbyUsers = const {},
    this.localUser,
    this.isLive = false,
  });

  DirectorModel copyWith({
    RtcEngine? engine,
    AgoraRtmClient? client,
    AgoraRtmChannel? channel,
    Set<AgoraUser>? activeUsers,
    Set<AgoraUser>? lobbyUsers,
    AgoraUser? localUser,
    bool? isLive,
  }) {
    return DirectorModel(
      engine: engine ?? this.engine,
      client: client ?? this.client,
      channel: channel ?? this.channel,
      activeUsers: activeUsers ?? this.activeUsers,
      lobbyUsers: lobbyUsers ?? this.lobbyUsers,
      localUser: localUser ?? this.localUser,
      isLive: isLive ?? this.isLive,
    );
  }
}
