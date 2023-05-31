class Temperature {
  Temperature({required this.timestamp, required this.measure});

  final double timestamp;
  final double measure;

  String get time => DateTime.fromMillisecondsSinceEpoch(timestamp.toInt())
      .toLocal()
      .toString()
      .substring(11, 16);

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      timestamp: json['time'].toDouble(),
      measure: json['temperature'].toDouble(),
    );
  }
}
