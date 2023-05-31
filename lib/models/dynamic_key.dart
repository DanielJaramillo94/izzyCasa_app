class DynamicKey {
  DynamicKey({required this.code, required this.timestamp});

  final String code;
  final double timestamp;

  Duration get remainingTime {
    var now = DateTime.now().millisecondsSinceEpoch;
    var elapsed = now - timestamp;
    var remainingTime = 30000 - elapsed;
    return Duration(milliseconds: remainingTime.toInt());
  }

  factory DynamicKey.fromJson(Map<String, dynamic> json) {
    return DynamicKey(
      code: json['code'].toString(),
      timestamp: json['time'].toDouble(),
    );
  }
}
