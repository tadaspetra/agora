import 'package:creatorstudio/models/user.dart';

class Message {
  String sendMuteMessage({required int uid, required bool mute}) {
    if (mute) {
      return "mute $uid";
    } else {
      return "unmute $uid";
    }
  }

  String sendDisableVideoMessage({required int uid, required bool enable}) {
    if (enable) {
      return "enable $uid";
    } else {
      return "disable $uid";
    }
  }

  String sendActiveUsers({required Set<AgoraUser> activeUsers}) {
    String _userString = "activeUsers ";
    for (int i = 0; i < activeUsers.length; i++) {
      _userString = _userString + activeUsers.elementAt(i).uid.toString() + ",";
    }
    return _userString;
  }

  List<int> parseActiveUsers({required String uids}) {
    List<String> activeUsers = uids.split(",");
    List<int> intUid = [];
    for (int i = 0; i < activeUsers.length; i++) {
      if (activeUsers[i] == "") continue;
      intUid.add(int.parse(activeUsers[i]));
    }
    print(intUid);
    return intUid;
  }
}
