import 'package:flutter_riverpod/flutter_riverpod.dart';

// access to repository inteface. Should not be touched in UI
final hostRepoProvider = Provider<HostRepository>((ref) => HostRepository(ref.read));

class HostRepository {
  Reader read;
  HostRepository(this.read);

  Future<void> createLiveStream(String channelName, String token) {
    throw (UnimplementedError);
  }

  Future<void> startLiveStream() {
    throw (UnimplementedError);
  }

  Future<void> endLiveStream() {
    throw (UnimplementedError);
  }

  Future<void> toggleUserMicrophone(int uid) {
    throw (UnimplementedError);
  }

  Future<void> toggleUserCamera(int uid) {
    throw (UnimplementedError);
  }

  Future<void> addStreamDestination() {
    throw (UnimplementedError);
  }
}
