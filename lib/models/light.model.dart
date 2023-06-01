class Light {
  const Light({
    required this.location,
    required this.label,
    required this.state,
  });

  final String location;
  final String label;
  final bool state;

  factory Light.fromJson(Map<String, dynamic> json) {
    return Light(
      location: json['location'],
      label: json['label'],
      state: json['status'].toString().toLowerCase() == 'true',
    );
  }
}
