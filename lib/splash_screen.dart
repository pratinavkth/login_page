import 'package:flutter/material.dart';
import 'package:login_page/homescreen/screen/homescreen.dart';
import 'package:login_page/login/screens/login.dart';
import 'package:login_page/login/server/signin_service.dart';
import 'package:login_page/signup/screens/signup.dart';
class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    // final AuthSigninService authSigninService = AuthSigninService();


    // void Loggedin(){
    //   authSigninService.loggedinonetime(context: context);
    // }


    return Scaffold(
        body: FutureBuilder<bool>(
          future:AuthSigninService().loggedInStatus() ,
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: 
              CircularProgressIndicator()
              );
            }
            else if(snapshot.hasData ){
              bool isLoggedin = snapshot.data ?? false;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (isLoggedin) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Homescreen())
                  );
                } else {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Signup())
                  );
                }
              });
            }

            else if(snapshot.hasError){
              return Center(child: Text("Error: ${snapshot.error}"));

            }
            return const Login();

          }
        )
        
        
         
    );
  }
}