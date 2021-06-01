import 'package:flutter/material.dart';

class LogController extends ValueNotifier<List<String>> {
  LogController() : super([]);

  void addLog(String log) {
    value = [log, ...value];
  }
}
