import 'package:flutter/material.dart';
// import 'package:flutter/flutter_straggered_grid_view.dart';
// import 'package:flutter/';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:login_page/notes/screen/new_note.dart';
import 'package:login_page/constants/searchbar.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
      // body: Column(children: [
      //   Padding(
      //     padding: EdgeInsets.only(top: 5),
      //     // child: const Searchbar(),
      //     child: MasonryGridView.count(
      //         crossAxisCount: 2,
      //         itemBuilder: (context, index) {
      //           return GestureDetector(
      //             onTap: () {},
      //           );
      //         }),
      //   ),
        
      // ]),
      
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
