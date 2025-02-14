import 'package:flutter/material.dart';

class Profilescreen extends StatefulWidget{
  const Profilescreen({Key? key}) : super(key: key);

  @override
  State<Profilescreen> createState()=> _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}