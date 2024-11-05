# TapSubmit Flutter SDK

This repository contains the TapSubmit Flutter SDK.

TapSubmit is a simple and affordable SaaS collecting input from users either through feedback or contact forms and with spam filtering passing these to your email.

It is intended for devleopers as a fully customizable yet cost-effective alternative to things such as WPForm or Typeform.

## Usage

Most bare minimum usage is as follows:

```dart
final client = TapSubmitClient(apiKey: 'your-api-key');
final response = await client.submit({
  'name': 'John Doe',
  'email': 'john.doe@example.com',
});

if (response.success) {
  print('Form submitted successfully');
} else {
  print('Form submission failed: ${response.errorMessage}');
}
```

See also the [example/](example/) folder for a full example.

## Get an account

For now, this is invite only, contact me at david@greycastle.se for a free api key.