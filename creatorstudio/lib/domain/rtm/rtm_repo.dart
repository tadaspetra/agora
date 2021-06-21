import 'package:flutter_riverpod/flutter_riverpod.dart';

final rtmRepoProvider = Provider<RtmRepo>((ref) => RtmRepo(ref.read));

class RtmRepo {
  Reader read;
  RtmRepo(this.read);

  Future<void> initializeClient(String channelName, String token) {
    throw (UnimplementedError);
  }

  Future<void> initializeChannel(String channelName, String token) {
    throw (UnimplementedError);
  }
}
