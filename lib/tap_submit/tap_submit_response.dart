class TapSubmitResponse {
  final bool success;
  final String? errorMessage;
  final TapSubmitErrorCode? errorCode;

  TapSubmitResponse({
    required this.success,
    this.errorMessage,
    this.errorCode,
  });

  @override
  String toString() =>
      'TapSubmitResponse: ${success ? 'Success' : errorMessage}';
}

enum TapSubmitErrorCode {
  invalidApiKey,
  invalidRequest,
  serverError,
}
