import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';

class HostCall {
  RtcEngine? engine;
  AgoraRtmClient? client;
  AgoraRtmChannel? channel;

  HostCall({
    this.client,
    this.channel,
    this.engine,
  });

  HostCall copyWith({
    RtcEngine? engine,
    AgoraRtmClient? client,
    AgoraRtmChannel? channel,
  }) {
    return HostCall(
      engine: engine ?? this.engine,
      client: client ?? this.client,
      channel: channel ?? this.channel,
    );
  }
}
