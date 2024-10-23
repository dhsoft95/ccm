class Supporter {
  int? id;
  String? first_name;
  String? last_name;
  String? dob;
  String? gender;
  String? region_id;
  String? village_id;
  String? ward_id;
  String? district_id;
  String? phone_number;
  int? promised;
  String? other_supporter_details;

  Supporter({
    this.id,
    this.first_name,
    this.last_name,
    this.dob,
    this.gender,
    this.region_id,
    this.village_id,
    this.ward_id,
    this.district_id,
    this.phone_number,
    this.promised,
    this.other_supporter_details,
  });

  get otherSupporterDetails => null;

  Map<String, dynamic> toJson() {
    return {
      "first_name": first_name,
      "last_name": last_name,
      "gender": gender,
      "phone_number": phone_number,
      "promised": promised?.toString(),
      "other_supporter_details": other_supporter_details,
    };
  }

  factory Supporter.fromJson(Map<String, dynamic> json) {
    return Supporter(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      dob: json['dob'],
      gender: json['gender'],
      region_id: json['region_id'].toString(),
      village_id: json['village_id'].toString(),
      ward_id: json['ward_id'].toString(),
      district_id: json['district_id'].toString(),
      phone_number: json['phone_number'],
      promised: json['promised'] is int ? json['promised'] : int.tryParse(json['promised'].toString()) ?? 0,
      other_supporter_details: json['other_supporter_details'],
    );
  }
}
