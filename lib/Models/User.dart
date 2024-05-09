class User{


  String? id;
  String? email;
  String? password;


  User({this.id, this.email, this.password});


  Map toLogin(){
    return {
      "email":email,
      "password":password
    };
  }






}