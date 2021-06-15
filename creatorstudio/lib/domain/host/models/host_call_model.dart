import 'package:agora_rtc_engine/rtc_engine.dart';

class HostCall {
  final RtcEngine? engine;

  HostCall({
    this.engine,
  });

  HostCall copyWith({
    RtcEngine? engine,
  }) {
    return HostCall(
      engine: engine ?? this.engine,
    );
  }
}
