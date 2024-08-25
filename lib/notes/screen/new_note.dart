import 'package:flutter/material.dart';
class NewNote extends StatefulWidget{
  const NewNote({Key? key}):super(key: key);

  @override
  State<NewNote> createState()=> _NewNoteState();
}

class _NewNoteState extends State<NewNote>{
  @override
  Widget build(BuildContext context){
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _contentController = TextEditingController();
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
        
        
        child: Column(
          children: [
            if (_titleController.text.isEmpty)
              ElevatedButton(onPressed:(){
                Navigator.pop(context);
              
              }, 
              child: Icon(Icons.close),)
              else
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){},child: Icon(Icons.more_horiz),),
                  ElevatedButton(onPressed: (){},child: 
                  
                  const Text("Done",
                  ),
                  
                  )
                  

                ],
              )
            ,
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                
                hintText: 'Untitled',
              ),
            ),

            SingleChildScrollView(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tap here to continue...',
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}