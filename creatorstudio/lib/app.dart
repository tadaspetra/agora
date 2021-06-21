import 'package:creatorstudio/pages/director/joindirector.dart';
import 'package:creatorstudio/pages/participant/joinparticipant.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("What is your role?"),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const JoinParticipantPage())),
                  child: Text("Participant"),
                ),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const JoinDirectorPage())),
                  child: Text("Director"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
