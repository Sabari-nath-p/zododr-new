class MedicalRecordModel {
  String? id;
  String? userId;
  String? childUserId;
  String? file;
  String? createdAt;
  String? updatedAt;

  MedicalRecordModel({
    this.id,
    this.userId,
    this.childUserId,
    this.file,
    this.createdAt,
    this.updatedAt,
  });

  MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    childUserId = json["child_user_id"];
    file = json["file"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "child_user_id": childUserId,
      "file": file,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}