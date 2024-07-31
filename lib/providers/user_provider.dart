import 'package:flutter/material.dart';
import 'package:login_page/models/user.dart';

class UserProvider extends ChangeNotifier{
  User _user = User(
    email: '', 
    password: '', 
    confirmPassword: '',
     );

  User get user => _user;

  void setUser(String user){
    _user = User.fromJson(user);
    notifyListeners();
  }
}