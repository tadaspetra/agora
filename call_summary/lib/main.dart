import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'call.dart';
import 'consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String summary = '';
  late final GenerativeModel model;

  @override
  void initState() {
    super.initState();
    model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  }

  void retrieveSummary(String transcription) async {
    final content = [
      Content.text(
        'This is a transcript of a video call that occurred. Please summarize this call in a few sentences. Dont talk about the transcript just give the summary. This is the transcript: $transcription',
      ),
    ];
    final response = await model.generateContent(content);
    setState(() {
      summary = response.text ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Call(
                      channelName: 'test',
                      retrieveSummary: retrieveSummary,
                    ),
                  ),
                ),
                child: const Text('Start Video Call'),
              ),
              const SizedBox(height: 10),
              summary != ''
                  ? const Row(
                      children: [
                        Text(
                          "Summary of the previous call",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : const SizedBox(),
              Text(summary),
            ],
          ),
        ),
      ),
    );
  }
}
