class SpecialisationModel {
  String? name;
  String? description;
  String? image;
  String? id;

  SpecialisationModel({this.name, this.description, this.image});

  SpecialisationModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json['name'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
