import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_page/homescreen/screen/homescreen.dart';
import 'package:login_page/login/screens/login.dart';
import 'package:login_page/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/global_variable.dart';
import 'package:login_page/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
class AuthSignupService{

  void signupUser({
    required BuildContext context,
    required String email,
    required String password,
    required String comfirmPassword,

  })async{
    try {
      User user= User(
        email: email,
        password: password,
        confirmPassword: comfirmPassword,
        token: '',
        id: '',
      

      );
      print(uri);
      print(user.toJson());
      
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String,String>{
          'Content-Type':'application/json; charset=UTF-8'
        }
      );
      // print(res.body);
      print(res.statusCode);
      if(res.statusCode == 200){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Provider.of<UserProvider>(context, listen: false).setUser(res.body);
        const SnackBar(content: Text('Signup successful'));
        await prefs.setString('user', res.body);
        Navigator.pushReplacement(context,
         MaterialPageRoute(builder: (context)=> const Login()));
      
         
     
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to signup'),
            // backgroundColor: Colors.red,
          )
        );
      
      }
      
    } catch (e) {
      SnackBar(content: Text(toString()));

    }

  }
}
