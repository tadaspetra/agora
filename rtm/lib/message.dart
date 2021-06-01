import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:test_project/logs.dart';

class MessageScreen extends StatefulWidget {
  final AgoraRtmClient client;
  final AgoraRtmChannel channel;
  final LogController logController;

  MessageScreen({this.client, this.channel, this.logController});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final _peerUserId = TextEditingController();
  final _peerMessage = TextEditingController();
  final _channelMessage = TextEditingController();

  void _isUserOnline() async {
    if (_peerUserId.text.isEmpty) {
      widget.logController.addLog('Please input peer user id to query.');
      return;
    }
    try {
      Map<dynamic, dynamic> result = await widget.client.queryPeersOnlineStatus([_peerUserId.text]);
      widget.logController.addLog('Query result: ' + result.toString());
    } catch (errorCode) {
      widget.logController.addLog('Query error: ' + errorCode.toString());
    }
  }

  void _sendPeerMessage() async {
    if (_peerUserId.text.isEmpty) {
      widget.logController.addLog('Please input peer user id to send message.');
      return;
    }
    if (_peerMessage.text.isEmpty) {
      widget.logController.addLog('Please input text to send.');
      return;
    }

    try {
      AgoraRtmMessage message = AgoraRtmMessage.fromText(_peerMessage.text);
      await widget.client.sendMessageToPeer(_peerUserId.text, message, false);
      widget.logController.addLog('Send peer message success.');
    } catch (errorCode) {
      widget.logController.addLog('Send peer message error: ' + errorCode.toString());
    }
  }

  void _sendChannelMessage() async {
    if (_channelMessage.text.isEmpty) {
      widget.logController.addLog('Please input text to send.');
      return;
    }
    try {
      await widget.channel.sendMessage(AgoraRtmMessage.fromText(_channelMessage.text));
      widget.logController.addLog('Send channel message success.');
    } catch (errorCode) {
      widget.logController.addLog('Send channel message error: ' + errorCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            widget.client.logout();
            Navigator.pop(context);
          },
        ),
        title: const Text('Agora Real Time Message'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(child: TextField(controller: _peerUserId, decoration: InputDecoration(hintText: 'Input peer user id'))),
                OutlinedButton(
                  child: Text(
                    'Check if User Online',
                  ),
                  onPressed: _isUserOnline,
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: TextField(controller: _peerMessage, decoration: InputDecoration(hintText: 'Input peer message'))),
                OutlinedButton(
                  child: Text('Send to Peer'),
                  onPressed: _sendPeerMessage,
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: TextField(controller: _channelMessage, decoration: InputDecoration(hintText: 'Input channel message'))),
                OutlinedButton(
                  child: Text(
                    'Send to Channel',
                  ),
                  onPressed: _sendChannelMessage,
                )
              ],
            ),
            ValueListenableBuilder(
              valueListenable: widget.logController,
              builder: (context, log, widget) {
                return Expanded(
                  child: Container(
                    child: ListView.builder(
                      itemExtent: 24,
                      itemBuilder: (context, i) {
                        return ListTile(
                          contentPadding: const EdgeInsets.all(0.0),
                          title: Text(log[i]),
                        );
                      },
                      itemCount: log.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
