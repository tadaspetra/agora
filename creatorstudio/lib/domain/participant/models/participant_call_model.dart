import 'package:agora_rtc_engine/rtc_engine.dart';

class ParticipantCall {
  final RtcEngine? engine;

  ParticipantCall({
    this.engine,
  });

  ParticipantCall copyWith({
    RtcEngine? engine,
  }) {
    return ParticipantCall(
      engine: engine ?? this.engine,
    );
  }
}
