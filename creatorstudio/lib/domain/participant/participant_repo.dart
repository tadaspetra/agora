import 'package:flutter_riverpod/flutter_riverpod.dart';

final participantRepoProvider = Provider<ParticipantRepo>((ref) => ParticipantRepo(ref.read));

class ParticipantRepo {
  Reader read;
  ParticipantRepo(this.read);

  Future<void> joinCall(String channelName, String token) {
    throw (UnimplementedError);
  }

  Future<void> toggleMute() {
    throw (UnimplementedError);
  }

  Future<void> toggleCamera() {
    throw (UnimplementedError);
  }

  Future<void> endCall() {
    throw (UnimplementedError);
  }
}
