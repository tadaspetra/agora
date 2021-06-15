import 'package:creatorstudio/config/palette.dart';
import 'package:creatorstudio/domain/host/models/host_call_model.dart';
import 'package:creatorstudio/global_widgets/custom_text_field.dart';
import 'package:creatorstudio/providers/host_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'director.dart';

class JoinDirectorPage extends StatefulWidget {
  const JoinDirectorPage();

  @override
  _DirectorPageState createState() => _DirectorPageState();
}

class _DirectorPageState extends State<JoinDirectorPage> {
  TextEditingController channelNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Director Studio",
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
                HostNotifier host = watch(hostNotifier.notifier);
                return ElevatedButton(
                  onPressed: () {
                    host.joinCall(channel: channelNameController.text);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DirectorPage()));
                  },
                  child: Text("Create Channel"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
