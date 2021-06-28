import 'package:agora_rtc_engine/rtc_engine.dart';

class DirectorModel {
  RtcEngine? engine;
  int? streamId;
  int? localUid;
  bool localMuted;

  DirectorModel({this.engine, this.streamId, this.localUid, this.localMuted = false});

  DirectorModel copyWith({
    RtcEngine? engine,
    int? streamId,
    int? localUid,
    bool? localMuted,
  }) {
    return DirectorModel(
      engine: engine ?? this.engine,
      streamId: streamId ?? this.streamId,
      localUid: localUid ?? this.localUid,
      localMuted: localMuted ?? this.localMuted,
    );
  }
}
