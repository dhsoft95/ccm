class Supporter {
  String? first_name;
  String? last_name;
  String? dob;
  String? gender;
  String? region_id;
  String? village_id;
  String? ward_id;
  String? district_id;
  String? phone_number;
  String? promised;
  String? other_supporter_details;

  Supporter(
      {this.first_name,
      this.last_name,
      this.dob,
      this.gender,
      this.region_id,
      this.village_id,
      this.ward_id,
      this.district_id,
      this.phone_number,
      this.promised,
      this.other_supporter_details});

  Map toJson() {
    return {
      "first_name": "<string>",
      "last_name": "<string>",
      "dob": "<string>",
      "gender": "<string>",
      "region_id": "<integer>",
      "village_id": "<integer>",
      "ward_id": "<integer>",
      "district_id": "<integer>",
      "phone_number": "<string>",
      "promised": "<boolean>",
      "other_supporter_details": "<string>"
    };
  }

  factory Supporter.fromJson(Map<String, dynamic> json) {
    return Supporter(
      first_name: json['first_name'],
      last_name: json['last_name'],
      dob: json['dob'],
      gender: json['gender'],
      region_id: json['region_id'],
      village_id: json['village_id'],
      ward_id: json['ward_id'],
      district_id: json['district_id'],
      phone_number: json['phone_number'],
      promised: json['promised'],
      other_supporter_details: json['other_supporter_details'],
    );
  }
}
