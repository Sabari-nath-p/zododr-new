class Prescription {
  final String id;
  final String bookingId;
  final String userId;
  final String file;
  final DateTime createdAt;

  Prescription({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.file,
    required this.createdAt,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['id'] ?? '',
      bookingId: json['booking_id'] ?? '',
      userId: json['user_id'] ?? '',
      file: json['file'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}