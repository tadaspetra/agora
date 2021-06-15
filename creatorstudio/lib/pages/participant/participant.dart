import 'package:creatorstudio/config/palette.dart';
import 'package:creatorstudio/global_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ParticipantPage extends StatefulWidget {
  const ParticipantPage();

  @override
  _ParticipantPageState createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage> {
  TextEditingController channelNameController = TextEditingController();
  TextEditingController tokenController = TextEditingController();
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
            CustomTextFieldWidget(
              hintText: "Token",
              textController: tokenController,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Join Channel"))
          ],
        ),
      ),
    );
  }
}
