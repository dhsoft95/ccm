class User{


  String? id;
  String? full_name;
  String? email;
  String? phone;
  String? party_affiliation;
  String? position_id;
  String? position_name;
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
      this.position_name,
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
      "position_name":position_name,
      "phone":phone,
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
  Map toUpdateProfile(){
    return {
      "full_name": full_name,
      "email": email,
      "phone": phone,
      "position_id": position_id
    };
  }



  factory User.fromAuthJson(Map<String,dynamic> json){
    return User(
      email: json['user']['email'],
      full_name:json['user']['full_name'],
      phone:json['user']['phone'],
        position_name:json['user']['position_name'],
      token: json['token']
    );
  }

  factory User.fromJson(Map<String,dynamic> json){

    return User(
      email: json['email'],
      full_name:json['full_name'],
      phone:json['phone'],
        position_name:json['position_name'],
      token: json['token']
    );
  }






}