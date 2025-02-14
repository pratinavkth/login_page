import 'package:flutter/material.dart';
import 'package:login_page/notes/models/create_notes.dart';
import 'package:login_page/notes/screen/edit_screen.dart';
class Searchbar extends SearchDelegate<String> {
  // required this.name
  final List<FetchNotes> notes;
   Searchbar(this.notes);
  @override
  List<Widget>? buildActions(BuildContext context){
    return[IconButton(onPressed:(){
      query ="";
    },
        icon: const Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, "");
        },
        icon:const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<FetchNotes> filteredNotes = notes.where((note)=>note.title.toLowerCase().contains(query.toLowerCase())).toList();

   return ListView.builder(
       itemCount: filteredNotes.length,
       itemBuilder: (context,index){
         return ListTile(
           title: Text(filteredNotes[index].title),
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>EditScreen(noteId: filteredNotes[index].noteId)));
           },
         );
       });
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    List<FetchNotes> filteredNotes = notes.where((note)=>note.title.toLowerCase().contains(query.toLowerCase())).toList();
    List<FetchNotes> limitedNotes = filteredNotes.take(5).toList();
    return ListView.builder(
      itemCount: limitedNotes.length,
      itemBuilder: (context,index){
          return ListTile(
            title: Text("${filteredNotes[index].title}"),
            onTap: (){
              query = "${filteredNotes[index].title}";
              showResults(context);
            },
          );
        });
      }
}