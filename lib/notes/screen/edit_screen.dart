import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget{
  const EditScreen ({Key?key}):super(key: key);

  @override

  State<EditScreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<EditScreen>{
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

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

                    onPressed: () {},
                    icon: Image.asset("assets/logo_noteit.png")),
              ),
              // const Spacer(),
              TextButton(onPressed: (){},
                  child: const Text(
                    'Save',
                  ),
              ),
            ],
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: ScreenHeight*0.01,left: ScreenWidth*0.05,right: ScreenWidth*0.05),
        child: Column(
          children: [
            // SizedBox(
            //   height: ScreenHeight*0.05,
            // ),
            TextField(
              controller: titleController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'untitled',
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
      ),
    );
  }
}