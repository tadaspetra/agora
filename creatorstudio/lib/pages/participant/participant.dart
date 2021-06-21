import 'package:agora_uikit/agora_uikit.dart';
import 'package:creatorstudio/domain/participant/models/participant_call_model.dart';
import 'package:creatorstudio/providers/participant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParticipantPage extends StatefulWidget {
  const ParticipantPage({Key? key}) : super(key: key);

  @override
  _ParticipantPageState createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
        ParticipantCall participant = watch(participantController);
        return Scaffold(
          body: Center(
            child: Stack(children: [
              AgoraVideoViewer(client: participant.client!),
              AgoraVideoButtons(client: participant.client!),
            ]),
          ),
        );
      },
    );
  }
}
