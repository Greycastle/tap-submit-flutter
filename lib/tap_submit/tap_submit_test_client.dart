import 'package:tap_submit/tap_submit/tap_submit_client.dart';
import 'package:tap_submit/tap_submit/tap_submit_response.dart';

/// Helper to use for testing.
class TapSubmitTestClient extends TapSubmitClient {
  final TapSubmitResponse Function(Map<String, dynamic>) onSubmit;

  TapSubmitTestClient({required this.onSubmit})
      : super(apiKey: 'testing-api-key');

  @override
  Future<TapSubmitResponse> submit(Map<String, dynamic> data) async {
    return onSubmit(data);
  }
}
