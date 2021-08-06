import 'package:creatorstudio/models/user.dart';
import 'package:flutter/material.dart';

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

  List<AgoraUser> parseActiveUsers({required String uids}) {
    List<String> activeUsers = uids.split(",");
    List<AgoraUser> users = [];
    for (int i = 0; i < activeUsers.length; i++) {
      if (activeUsers[i] == "") continue;
      users.add(AgoraUser(
          uid: int.parse(
        activeUsers[i],
      )));
    }
    print(users);
    return users;
  }

  String sendUserInfo({required int uid, required String name, required int color}) {
    return "updateUser $uid,$name,$color";
  }

  List<AgoraUser> parseUserInfo({required List<AgoraUser> currentUsers, required String userInfo}) {
    List<String> information = userInfo.split(","); // uid,name,color
    List<AgoraUser> tempUser = currentUsers;
    for (int i = 0; i < tempUser.length; i++) {
      if (tempUser[i].uid == int.parse(information[0])) {
        tempUser[i] = tempUser[i].copyWith(name: information[1], backgroundColor: Color(int.parse(information[2])));
      }
    }
    return tempUser;
  }
}
