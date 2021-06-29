class AgoraUser {
  int uid;
  bool muted;
  bool videoDisabled;

  AgoraUser({
    required this.uid,
    this.muted = false,
    this.videoDisabled = false,
  });

  AgoraUser copyWith({
    int? uid,
    bool? muted,
    bool? videoDisabled,
  }) {
    return AgoraUser(
      uid: uid ?? this.uid,
      muted: muted ?? this.muted,
      videoDisabled: videoDisabled ?? this.videoDisabled,
    );
  }
}
