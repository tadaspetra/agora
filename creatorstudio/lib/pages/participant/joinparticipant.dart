import 'package:creatorstudio/config/palette.dart';
import 'package:creatorstudio/global_widgets/custom_text_field.dart';
import 'package:creatorstudio/pages/participant/participant.dart';
import 'package:creatorstudio/providers/participant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinParticipantPage extends StatefulWidget {
  const JoinParticipantPage();

  @override
  _ParticipantPageState createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<JoinParticipantPage> {
  TextEditingController channelNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Participant",
          style: TextStyle(color: Palette.black),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Palette.black,
        iconTheme: IconThemeData(color: Palette.black),
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFieldWidget(
              hintText: "Channel Name",
              textController: channelNameController,
            ),
            Consumer(
              builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
                ParticipantController participant = watch(participantController.notifier);
                return ElevatedButton(
                    onPressed: () {
                      participant.joinCall(channel: channelNameController.text);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ParticipantPage()));
                    },
                    child: Text("Join Channel"));
              },
            )
          ],
        ),
      ),
    );
  }
}
