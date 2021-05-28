import 'package:creatorstudio/global_widgets/custom_text_field.dart';
import 'package:creatorstudio/pages/director/director.dart';
import 'package:creatorstudio/pages/participant/participant.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("What is your role?"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ParticipantPage())),
                  child: const Text("Participant"),
                ),
                const SizedBox(
                  width: 4,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DirectorPage())),
                  child: const Text("Director"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
