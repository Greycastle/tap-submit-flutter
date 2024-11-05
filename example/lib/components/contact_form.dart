import 'package:flutter/material.dart';
import 'package:tapsubmit_sdk_example/models/submission_model.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({
    super.key,
    required this.isEnabled,
    required this.onSubmit,
  });

  final bool isEnabled;
  final void Function(SubmissionModel submission) onSubmit;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _simulateFailure = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
            ),
            keyboardType: TextInputType.emailAddress,
            enabled: widget.isEnabled,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Enter your name',
            ),
            enabled: widget.isEnabled,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          CheckboxListTile(
            title: const Text('Simulate Failure'),
            value: _simulateFailure,
            onChanged: widget.isEnabled
                ? (bool? value) {
                    setState(() {
                      _simulateFailure = value ?? false;
                    });
                  }
                : null,
          ),
          ElevatedButton(
            onPressed: widget.isEnabled
                ? () {
                    if (_formKey.currentState!.validate()) {
                      _submitForm();
                    }
                  }
                : null,
            child: const Text('Submit'),
          )
        ]));
  }

  void _submitForm() {
    widget.onSubmit(SubmissionModel(
      email: _emailController.text,
      name: _nameController.text,
      simulateFailure: _simulateFailure,
    ));
  }
}
