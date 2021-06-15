import 'package:creatorstudio/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: CustomTheme().lightTheme(),
        home: App(),
      ),
    ),
  );
}
