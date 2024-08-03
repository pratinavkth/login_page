import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_page/homescreen/screen/homescreen.dart';
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
      http.Response res = await http.post(
       
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String,String>{
          'Content-Type':'application/json; charset=UTF-8'
        }
      );
      if(res.statusCode == 200){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Provider.of<UserProvider>(context, listen: false).setUser(res.body);
        const SnackBar(content: Text('Signup successful'));
        await prefs.setString('user', res.body);
        Navigator.pushReplacement(context,
         MaterialPageRoute(builder: (context)=> const Homescreen()));
      
        
     
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
  void getUserData({
    required BuildContext context,
  })async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if(token == null){
        prefs.setString('x-auth token', '');
           }
      var tokenres= await http.post(Uri.parse('$uri/tokenisvalid'),
      headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8',
        'x-auth-token': token!,
      }
      );
      var response= jsonDecode(tokenres.body);
      if(response==true){
        http.Response useRes= await http.get(Uri.parse('$uri/'),
        headers: <String,String>{
          'Content-Type':'application/json; charset=UTF-8',
          'x-auth-token': token,
        }
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(useRes.body);

      }
  

    } catch (e) {
      SnackBar(content: Text(e.toString()));
    }
  }

}