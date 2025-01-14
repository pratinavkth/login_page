import 'package:flutter/material.dart';
import 'recording.dart';
class Audio extends StatefulWidget {
  const Audio({Key? key}) : super(key: key);

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
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
      body:Column(
        children: [
          Padding(
            padding:EdgeInsets.only(top: screenHeight*0.05, left: screenWidth*0.40,right: screenWidth*0.25,bottom: screenHeight*0.2) ,
           
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Recording()));
             
              },
              icon: const Icon(Icons.mic,size:248,),
            )
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                 ListView.builder(itemBuilder: (context,index){
                  
                 }), 

                ],),
               ),
            ),
          
          
        ],)
    );
  }
}
