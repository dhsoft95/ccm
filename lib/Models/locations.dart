class Region {
  String? id;
  String? name;
  String? other_region_details;
  List<District>? districts;

  Region({this.id, this.name, this.other_region_details, this.districts});

  Map toJson() {
    return {
      "id": id,
      "name": name,
      "other_region_details": other_region_details,
      "districts": districts?.map((district) => district.toJson()).toList(),
    };
  }

  factory Region.fromJson(Map<String, dynamic> json) {
    List districtList = json['districts'];
    return Region(
        id: json['id'].toString(),
        name: json['name'],
        other_region_details: json['other_region_details'],
        districts: districtList
            .map((district) => District.fromJson(district))
            .toList());
  }
}

class District {
  String? id;
  String? region_id;
  String? name;
  String? other_district_details;
  List<Village>? villages;
  List<Ward>? wards;

  District(
      {this.id,
      this.region_id,
      this.name,
      this.other_district_details,
      this.villages,
      this.wards});

  Map toJson() {
    return {
      "id": id,
      "region_id": region_id,
      "name": name,
      "other_district_details": other_district_details,
      "villages": villages?.map((village) => village.toJson()).toList(),
      "wards": wards?.map((ward) => ward.toJson()).toList(),
    };
  }

  factory District.fromJson(Map<String, dynamic> json) {
    List ward = json['wards'];
    List villages = json['villages'];
    return District(
        id: json['id'].toString(),
        region_id: json['region_id'].toString(),
        name: json['name'],
        other_district_details: json['other_district_details'],
        wards: ward.map((wardItem) => Ward.fromJson(wardItem)).toList(),
        villages: villages
            .map((villageItem) => Village.fromJson(villageItem))
            .toList());
  }
}

class Village {
  String? id;
  String? region_id;
  String? district_id;
  String? name;
  String? other_villages_details;

  Village(
      {this.id,
      this.region_id,
      this.district_id,
      this.name,
      this.other_villages_details});

  Map toJson() {
    return {
      "id": id,
      "region_id": region_id,
      "district_id": district_id,
      "name": name,
      "other_villages_details": other_villages_details,
    };
  }

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      id: json['id'].toString(),
      region_id: json['region_id'].toString(),
      district_id: json['district_id'].toString(),
      name: json['name'],
      other_villages_details: json['other_villages_details'],
    );
  }
}

class Ward {
  String? id;
  String? region_id;
  String? district_id;
  String? village_id;
  String? name;
  String? other_villages_details;

  Ward(
      {this.id,
      this.region_id,
      this.district_id,
      this.village_id,
      this.name,
      this.other_villages_details});

  Map toJson() {
    return {
      "id": id,
      "region_id": region_id,
      "district_id": district_id,
      "village_id": village_id,
      "name": name,
      "other_villages_details": other_villages_details,
    };
  }

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      id: json['id'].toString(),
      region_id: json['region_id'].toString(),
      district_id: json['district_id'].toString(),
      village_id: json['village_id'].toString(),
      name: json['name'],
      other_villages_details: json['other_villages_details'],
    );
  }
}
