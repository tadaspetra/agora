import 'package:agora_uikit/agora_uikit.dart';

class ParticipantCall {
  final AgoraClient? client;

  ParticipantCall({
    this.client,
  });

  ParticipantCall copyWith({
    AgoraClient? client,
  }) {
    return ParticipantCall(
      client: client ?? this.client,
    );
  }
}
