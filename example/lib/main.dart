import 'package:flutter/material.dart';
import 'package:tapsubmit_sdk_example/form_page.dart';

void main() {
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
