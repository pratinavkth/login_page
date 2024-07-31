import 'package:flutter/material.dart';
import 'package:login_page/signup/screens/signup.dart';

void main() {
  runApp(const MyApp());
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
        // textTheme: Googlefonts.robotoTextTheme(
          // Theme.of(context).textTheme,
        // ),
      
      ),
      home: const Signup(),
    );
  }
}


