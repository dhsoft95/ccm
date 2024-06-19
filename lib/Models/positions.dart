class Positions {
  String? id;
  String? name;
  String? description;
  String? other_position_details;

  Positions(
      {this.id, this.name, this.description, this.other_position_details});

  @override
  String toString() {
    return name!;
  }

  Map toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "other_position_details": other_position_details,
    };
  }

  factory Positions.fromJson(Map<String, dynamic> json) {
    return Positions(
      id: json['id'].toString(),
      name: json['name'],
      description: json['description'],
      other_position_details: json['other_position_details'],
    );
  }
}
