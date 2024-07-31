import 'dart:convert';
class User{
  final String email;
  final String password;
  final String confirmPassword;

  User({
    required this.email,
    required this.password,
    required this.confirmPassword
  });

  Map<String ,dynamic>toMap(){
    return {
      'email':email,
      'password':password,
      'confirmPassword':confirmPassword
    };
  }

  factory User.fromMap(Map<String,dynamic> map) {
    return User(
      email:map['email'] ?? '', 
      password: map['password'] ?? '', 
      confirmPassword: map['confirmPassword'] ?? ''
      );
    
  }
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}