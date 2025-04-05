import 'package:flutter/material.dart';
import 'package:login_page/notes/models/create_notes.dart';
import 'package:login_page/notes/server/edit_screen_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class EditScreen extends StatefulWidget{
  final noteId;
   EditScreen ({Key?key,
   required this.noteId}):super(key: key);

  @override

  State<EditScreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<EditScreen>{
  late Future<List<Notes>> updatednote;
  late Future<Notes> fetchnotes;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final UpdateNotes edittheNote =UpdateNotes();
  
  @override
  void dispose(){
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }
  
  void initState() {
    super.initState();
    fetchnotes = edittheNote.fetchNoteById(
        context: context,
        noteId: widget.noteId
    );
    // updatednote = edittheNote.editNotes(
    //   context: context,
    //   title: titleController.text,
    //   content: contentController.text,
    //   date: DateTime.now().toString(),
    //   noteId: widget.noteId,
    // );
  }

  Future<void>saveupdatenote()async{
    final String title = titleController.text;
    final String content = contentController.text;
    final String date = DateTime.now().toString();
    final String noteId = widget.noteId;
    try{
    await UpdateNotes().editNotes(
      context: context, 
      title: title, 
      content: content, 
      date: date, 
      noteId: noteId);
      print("saving");
    } 
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context){
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: ScreenWidth * 0.03),
                child: IconButton(
                    onPressed: () {

                    },
                    icon: Image.asset("assets/logo_noteit.png")),
              ),
              // const Spacer(),
              TextButton(onPressed: ()async{
               await saveupdatenote();
                print("saved the note");
                setState(() {
                  fetchnotes= edittheNote.fetchNoteById(context: context, noteId: widget.noteId);
                });
              },
                  child: const Text(
                    'Save',
                  ),
              ),
            ],
          )
        ],
      ),
      body: FutureBuilder<Notes>(
        future: fetchnotes, 
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasError){
            return  Center(
              child: Text("Error of the snapshot:${snapshot.error}"),
            );
          }
          else if(snapshot.hasData){
            final note = snapshot.data!;
            titleController.text = note.title;
            contentController.text = note.content;

            return Container(
              padding: EdgeInsets.only(top: ScreenHeight*0.01,left: ScreenWidth*0.05,right: ScreenWidth*0.05),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize:24,

              ),
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                // hintText: 'untitled',
              ),
            ),
            SizedBox(
              height: ScreenHeight*0.01,
            ),
            const Divider(
              height: 5,
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: ScreenHeight*0.01,
            ),
            TextField(
              controller: contentController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'content'
              ),
            ),
          ],
        ),
            );
          }
          return const Center(
            child: Text("No data available"),
          );
        }
        ),
          );
  }
}