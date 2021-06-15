import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirectorPage extends StatelessWidget {
  const DirectorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
        return Scaffold(
          body: Center(
            child: Text("Director"),
          ),
        );
      },
    );
  }
}
