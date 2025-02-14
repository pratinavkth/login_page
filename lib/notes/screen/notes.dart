import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:login_page/notes/models/create_notes.dart';
import 'package:login_page/notes/screen/drawing.dart';
import 'package:login_page/notes/screen/edit_screen.dart';
import 'package:login_page/notes/screen/new_note.dart';
import 'package:login_page/notes/server/delete_note_service.dart';
import 'package:login_page/notes/server/notes_fetching.dart';
import 'package:login_page/profile/profileScreen/profilescreen.dart';

import '../../constants/searchbar.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late Future<List<FetchNotes>> futureNotes;
  late Future<List<Notes>> deleteNotes;
  final NotesFetching notesFetching = NotesFetching();
  final DeleteNotes deletetheNote = DeleteNotes();
  Set<int> selectedIndexes = {};
  bool _isExpanded = false;
  bool isSelectedMode = false;
  List<FetchNotes> notes = [];
  List<Notes> deletetheNotes = [];
  Color backColour = Colors.white;

  @override
  void initState() {
    super.initState();
    futureNotes = notesFetching.getNotes(context: context);
  }

  void _onLongPress(int index) {
    setState(() {
      backColour = Colors.black;
      isSelectedMode = true;
      selectedIndexes.add(index);
    });
  }

  void _selectAll() {
    setState(() {
      if (selectedIndexes.length == notes.length) {
        selectedIndexes.clear();
        isSelectedMode = false;
      } else {
        selectedIndexes = {for (int i = 0; i < notes.length; i++) i};
      }
    });
  }

  void _deletenote() {
    setState(() {
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: const Text("Delete the Note"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child:const Text("cancel") ),
            TextButton(onPressed: ()async{

                List<String> deleteselectNoteId =selectedIndexes.map((index)=>notes[index].noteId).whereType<String>().toList();

                for(String noteId in deleteselectNoteId){
                  // await DeleteNotes(noteId);
                  await deletetheNote.deletenotes(context: context, NoteId: noteId);

                }
                setState(() {
                  notes.removeWhere((note) => deleteselectNoteId.contains(note.noteId));
                  selectedIndexes.clear();
                  isSelectedMode = false;
                  Navigator.pop(context);
              });

            }, child: const Text("Delete"))
          ],
        );
      });

    });
  }

  void _sharedNote() {
    setState(() {
      List<String> seleectedItemss =
          selectedIndexes.map((index) => notes[index]).cast<String>().toList();
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: isSelectedMode
            ? PreferredSize(
                preferredSize: Size.fromHeight(screenHeight * 0.05),
                child: AppBar(
                  shape: const Border(bottom: BorderSide(color: Colors.grey)),
                  title: Text('${selectedIndexes.length} selected Notes'),
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        selectedIndexes.clear();
                        isSelectedMode = false;
                      });
                    },
                  ),
                  backgroundColor: Colors.white,
                  actions: [
                    IconButton(
                        onPressed: () {
                          _selectAll();
                        },
                        icon: const Icon(Icons.select_all)),
                    IconButton(
                        onPressed: () {
                          _deletenote();
                        },
                        icon: const Icon(Icons.delete)),
                    IconButton(
                        onPressed: () {
                          _sharedNote();
                        },
                        icon: const Icon(Icons.share)),
                  ],
                ))
            : PreferredSize(
                preferredSize: Size.fromHeight(screenHeight * 0.05),
                child: AppBar(
                  // elevation: 0.1,
                  shape: const Border(bottom: BorderSide(color: Colors.grey)),
                  // title: const Text('Search Notes'),
                  backgroundColor: Colors.white,
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.03),
                      child: const ImageIcon(
                        AssetImage("assets/logo_noteit.png"),
                        size: 100,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        showSearch(context: context, delegate: Searchbar(notes));
                      },
                      icon: const Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profilescreen()));
                      },
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
              } else if (snapshot.hasData) {
                notes = snapshot.data!;

                return MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    bool selectedNote = selectedIndexes.contains(index);
                    return Card(
                      color: selectedNote?Colors.blueGrey:Colors.white10,
                      child: InkWell(
                        onLongPress: () {
                          _onLongPress(index);
                        },
                        onTap: () {
                          print(notes[index].noteId);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditScreen(
                                        noteId: notes[index].noteId,
                                      )));
                        },
                        child: Center(
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
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No notes Available'),
                );
              }
            }),
        floatingActionButton: Stack(
          alignment: Alignment.bottomRight,
          children: [
            if (_isExpanded)
              // Positioned.fill(child:
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = false;
                  });
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  width: screenWidth * 1,
                  height: screenHeight * 2,
                ),
              ),
            Positioned(
              bottom: 80,
              right: 16,
              child: AnimatedOpacity(
                opacity: _isExpanded ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildOption(
                        icon: Icons.note_add,
                        label: "Add note",
                        onTap: () =>
                            _navigateToScreen(context, const NewNote())),
                    _buildOption(
                        icon: Icons.draw_outlined,
                        label: "draw",
                        onTap: () =>
                            _navigateToScreen(context, const Drawing())),
                  ],
                ),
              ),
            ),
            Positioned(
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Icon(
                  _isExpanded ? Icons.close : Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = false;
        });
        onTap();
      },
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: Offset(0, 2))
                ]),
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 8),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
