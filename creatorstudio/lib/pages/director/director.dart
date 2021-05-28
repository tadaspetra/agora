import 'package:creatorstudio/config/palette.dart';
import 'package:creatorstudio/global_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class DirectorPage extends StatefulWidget {
  const DirectorPage();

  @override
  _DirectorPageState createState() => _DirectorPageState();
}

class _DirectorPageState extends State<DirectorPage> {
  TextEditingController channelNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Director Studio",
          style: TextStyle(color: Palette.black),
        ),
        backgroundColor: Palette.lightGrey,
        foregroundColor: Palette.black,
        iconTheme: const IconThemeData(color: Palette.black),
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
            ElevatedButton(
                onPressed: () {
                  print(channelNameController.text);
                },
                child: const Text("Create Channel"))
          ],
        ),
      ),
    );
  }
}
