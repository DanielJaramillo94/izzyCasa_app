class RequestInconsistency {
  final String type;
  final String code;
  final String message;

  const RequestInconsistency({
    required this.type,
    required this.code,
    required this.message,
  });

  factory RequestInconsistency.fromJson(Map<String, dynamic> json) {
    return RequestInconsistency(
      type: json['type'] as String,
      code: json['code'] as String,
      message: json['message'] as String,
    );
  }
}
