import 'package:flutter/material.dart';
import 'package:login_page/signup/screens/signup.dart';
import 'package:login_page/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:login_page/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
    child:
    const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  }

  class _MyAppState extends State<MyApp>{

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:const  Color(0xFFFFFFFF),
      ),
      home: 
      const SplashScreen(),
    );
  }
}


