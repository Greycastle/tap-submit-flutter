class SubmissionModel {
  final String email;
  final String name;
  final bool simulateFailure;

  SubmissionModel({
    required this.email,
    required this.name,
    required this.simulateFailure,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
    };
  }
}
