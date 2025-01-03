import 'package:flutter/material.dart';

class Todo extends StatefulWidget{

  const Todo({Key?key}):super(key: key);
  @override
  State<Todo> createState()=> _TodoState();
}

class _TodoState extends State<Todo>{
  bool checkbox= false;
@override
  void initState() {
    if(checkbox)
     setState(() {
       checkbox = false;
     });
    super.initState();
  }

  final TextEditingController checkboxcomment = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Column(children: [
          Checkbox(value: checkbox, onChanged:(bool? value){
            setState(() {
              checkbox=false;
            });
          } )
        ],),
      ),
    );
  }
}