import 'package:flutter/material.dart';
import 'package:tapsubmit_sdk_example/components/contact_form.dart';
import 'package:tapsubmit_sdk_example/models/submission_model.dart';
import 'package:tapsubmit_sdk_example/utils/space_with_extension.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String? _error;
  bool _loading = false;
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TapSubmit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
              children: [
            const Text(
              'This is an example form using the TapSubmit Flutter SDK.',
            ),
            const Text(
              'If the app is configured correctly, submitting this will send an email to the configured address on the TapSubmit account.',
            ),
            const Divider(),
            if (_submitted) ...[
              const Text('Form submitted successfully!'),
              ElevatedButton(onPressed: _reset, child: const Text('Reset')),
            ],
            if (!_submitted) ...[
              ContactForm(isEnabled: _loading == false, onSubmit: _submitForm),
              if (_loading) const CircularProgressIndicator(),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red))
            ],
          ].spaceWith(16.0)),
        ),
      ),
    );
  }

  Future<void> _submitForm(SubmissionModel submission) async {
    setState(() {
      _error = null;
      _loading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (submission.simulateFailure) {
      setState(() {
        _error = 'Simulated failure';
        _loading = false;
      });
    } else {
      setState(() {
        _submitted = true;
        _loading = false;
      });
    }
  }

  void _reset() {
    setState(() {
      _submitted = false;
      _loading = false;
      _error = null;
    });
  }
}
