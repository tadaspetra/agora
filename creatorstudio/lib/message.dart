class Message {
  String sendMuteMessage({required int uid}) {
    return "audio $uid";
  }

  String sendDisableVideoMessage({required int uid}) {
    return "video $uid";
  }
}
