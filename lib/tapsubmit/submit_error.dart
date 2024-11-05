class SubmitError extends Error {
  final String message;
  final SubmitErrorType type;

  SubmitError(this.message, this.type);

  @override
  String toString() => 'SubmitError: $message, type: $type';
}

enum SubmitErrorType {
  invalidApiKey,
  invalidRequest,
  serverError,
}
