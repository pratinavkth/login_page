import 'package:flutter/material.dart';
import 'package:login_page/notes/server/new_note_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewNote extends StatefulWidget {
  const NewNote({Key? key}) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future <void> saveNote() async{
    final String title = _titleController.text;
    final String content = _contentController.text;
    final String date = DateTime.now().toString();
    SharedPreferences prefs =await SharedPreferences.getInstance();
    String? userId =prefs.getString('user');
    // Srting? token =prefs.getString('x-auth-token');
    if (userId == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('user not logged in!'))
      );
    }
    if(title.isNotEmpty && content.isNotEmpty){
      await NoteService().addNote(context: context, title: title, content: content, Date: date,);
      Navigator.pop(context);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Title and content cannot be empty'),
        )
      );
    
    }
  }
      
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
        child: Column(
          children: [
            if (_titleController.text.isEmpty)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Icon(Icons.more_horiz),
                  ),
                  TextButton(
                    onPressed: (){
                      saveNote();
                      // Navigator.pop(context);
                   
                    }, // saveNote
                    child: const Text(
                      "Done",
                    ),
                  )
                ],
              ),
            TextField(
              controller: _titleController,
              maxLines: null,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize:24,
                
              ),
              
              decoration: const InputDecoration(
                
                border: InputBorder.none,
                hintText: 'Untitled',
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              color: Colors.black,
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
            // SizedBox(height: screenHeight*0.7,),
            // Container(
            //   height: screenHeight*0.05,
            //   decoration: BoxDecoration(color: Colors.black),
            //   child: Row(
            //     children: [],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
  }
