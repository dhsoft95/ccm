class User{


  String? id;
  String? email;
  String? full_name;
  String? password;
  String? token;


  User({this.id, this.email, this.password,this.full_name,this.token});




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



  factory User.fromLoginJson(Map<String,dynamic> json){
    return User(
      email: json['user']['email'],
      full_name:json['user']['full_name'],
      token: json['token']
    );
  }






}