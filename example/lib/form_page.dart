import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tap_submit/tap_submit/tap_submit_client.dart';
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

    try {
      final apiKey = submission.simulateFailure
          ? 'invalid-api-key'
          : dotenv.env['TAP_SUBMIT_API_KEY']!;

      final client = TapSubmitClient(apiKey: apiKey);
      final data = submission.toJson();
      data['hidden-key'] = 'hidden-value';
      final response = await client.submit(data);
      if (response.success) {
        setState(() => _submitted = true);
      } else {
        setState(() => _error = response.errorMessage);
      }
    } catch (err, st) {
      debugPrint('$err\n$st');
      setState(() => _error = 'Error submitting form: $err');
    } finally {
      setState(() => _loading = false);
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
