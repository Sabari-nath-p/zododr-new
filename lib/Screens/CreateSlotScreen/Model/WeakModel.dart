class WeekModel {
  final String id;
  final String name;
  final int order;

  WeekModel({
    required this.id,
    required this.name,
    required this.order,
  });

  factory WeekModel.fromJson(Map<String, dynamic> json) {
    return WeekModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      order: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "order": order,
    };
  }
}