import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tapsubmit_sdk_example/form_page.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TapSubmit',
      home: FormPage(),
    );
  }
}
