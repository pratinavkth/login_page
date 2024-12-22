import 'dart:convert';
class User{
  final String id;
  final String email;
  final String password;
  final String confirmPassword;
  final String token;

  User({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.token,
    required this.id
  });

  Map<String,dynamic>toMap(){
    return {
      'email':email,
      'password':password,
      'confirmPassword':confirmPassword,
      'token':token,
      'id':id
    
    
    };
  }

  factory User.fromMap(Map<String,dynamic> map) {
    return User(
      email:map['email'] ?? '', 
      password: map['password'] ?? '', 
      confirmPassword: map['confirmPassword'] ?? '',
      token: map['token'] ?? '',
      id: map['_id'] ?? ''
    
      
      );
    
  }
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}