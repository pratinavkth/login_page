import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_page/global_variable.dart';
import 'package:login_page/login/screens/login.dart';
import 'package:login_page/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:login_page/providers/user_provider.dart';
import 'dart:convert';
import 'package:login_page/homescreen/screen/homescreen.dart';




class AuthSigninService{ 
  void SigninUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      
      User user = User(
        email: email, 
        password: password, 
        confirmPassword: '',
        token: '',
        id: ''
      
        );
        

        http.Response res = await http.post(Uri.parse(
          '$uri/api/signin'),
          body: user.toJson(),
          headers:
          <String,String>{
            'Content-Type':'application/json; charset=UTF-8',
            // token: '',
          
          });
          if(res.statusCode == 200){
            SharedPreferences prefs = await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
            // prefs.setString('user', jsonDecode(res.body)['user.id']);
            prefs.setString('user', jsonDecode(res.body)['user']['_id']);

            

            
            const SnackBar(content: Text('Signin Sucessfully'),);
            Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=> const Homescreen(),),
            (route) => false,
            );
            
         

          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to Signin'),
              )
            );
          }
    
    } catch (e) {
      SnackBar(content: Text(e.toString()));
    
      
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

  
      Future<bool> loggedInStatus()async{
        try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String?token = prefs.getString('x-auth-token');
      return token != null;
      }
      
    
    catch(e){
    SnackBar(content: Text(e.toString()));
    return false;
    }


  }


}