class User{


  String? id;
  String? full_name;
  String? email;
  String? phone;
  String? party_affiliation;
  String? position_id;
  String? region_id;
  String? village_id;
  String? ward_id;
  String? other_candidate_details;
  String? district_id;
  String? password;
  String? token;


  User(
      {this.id,
      this.full_name,
      this.email,
      this.phone,
      this.party_affiliation,
      this.position_id,
      this.region_id,
      this.village_id,
      this.ward_id,
      this.other_candidate_details,
      this.district_id,
      this.password,
      this.token});

  Map toJson(){
    return {
      "email":email,
      "full_name":full_name,
      "token":token
    };
  }


  Map toLogin(){
    return {
      "email":email,
      "password":password
    };
  }


  Map toRegistration(){
    return {
      "full_name": full_name,
      "email": email,
      "phone": phone,
      "party_affiliation": party_affiliation,
      "position_id": position_id,
      "region_id": region_id,
      "village_id": village_id,
      "ward_id": ward_id,
      "district_id": district_id,
      "other_candidate_details": other_candidate_details,
      "password": password
    };
  }



  factory User.fromLoginJson(Map<String,dynamic> json){
    return User(
      email: json['user']['email'],
      full_name:json['user']['full_name'],
      token: json['token']
    );
  }






}