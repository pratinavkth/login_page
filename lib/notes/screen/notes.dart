import 'package:flutter/material.dart';
// import 'package:flutter/flutter_straggered_grid_view.dart';
// import 'package:flutter/';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:login_page/notes/models/create_notes.dart';
import 'package:login_page/notes/screen/edit_screen.dart';
import 'package:login_page/notes/screen/new_note.dart';
import 'package:login_page/constants/searchbar.dart';
import 'package:login_page/notes/server/notes_fetching.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late Future<List<FetchNotes>> futureNotes;
  final NotesFetching notesFetching = NotesFetching();
  @override
  void initState() {
    super.initState();
    futureNotes = notesFetching.getNotes(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final NotesFetching notesFetching = NotesFetching();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.05),
        child: AppBar(
          // elevation: 0.1,
          shape: const Border(bottom: BorderSide(color: Colors.grey)),
          // title: const Text('Search Notes'),
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.03),
              child: IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/logo_noteit.png")),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                // showSearch(context: context, delegate: Searchbar());
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle_outlined),
            ),
          ],
        ),
      ),
      
      body: FutureBuilder<List<FetchNotes>>(
          future: futureNotes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error:${snapshot.error}'),
              );
            } else if(snapshot.hasData){
              List<FetchNotes> notes = snapshot.data!;
              return MasonryGridView.builder(
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(

                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const EditScreen()));
                      },
                      child: Column(
                        children: [

                          Text(
                            notes[index].title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(notes[index].content),
                          Text(notes[index].date),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            else {
            return const Center(
            child: Text('No notes Available why'),
            );
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewNote()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
