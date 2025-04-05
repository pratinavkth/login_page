import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_page/profile/profileScreen/update_password.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({Key? key}) : super(key: key);

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  late TextEditingController controllerName;
  late TextEditingController emailId;


  Future<void> _pickImageGallery() async {
    final pickedfilegallery =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedfilegallery != null) {
      setState(() {
        _image = pickedfilegallery;
      });
    }
  }

  Future<void> _pickeImageCamera() async {
    final pickedfilecamera =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedfilecamera != null) {
      setState(() {
        _image = pickedfilecamera;
      });
    }
  }

Widget displayImage(XFile?image ){
    if(image!=null){
      return Image.file(
        File(image.path),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }else{
      return const Text("No image Selected");
    }

}
  Future<void> showDialogBox()async {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Select the image source"),
            // content:
            actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style:const  ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.cyanAccent)
                  ),
                    onPressed: (){
                      Navigator.pop(context);
                      _pickeImageCamera();
                      },
                    child:const Column(
                      children: [
                        Icon(Icons.camera,size: 20,),
                        Text("Camera",style: TextStyle(fontSize: 20),),
                      ],
                    ),
                ),
                ElevatedButton(
                    style:const  ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.cyanAccent)
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      _pickImageGallery();
                      },
                    child:const Column(
                      children: [
                        Icon(Icons.photo_library_outlined,size: 20,),
                        Text("Gallery",style: TextStyle(fontSize: 20),),
                      ],
                    )
                ),

              ],
            ),
          ],
          );
        }
    );
}
@override
  void initState() {
    // TODO: implement initState
   controllerName = TextEditingController();
   emailId = TextEditingController();
    super.initState();
  }
@override
  void dispose(){
    controllerName.dispose();
    emailId.dispose();
    super.dispose();

}

  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;




    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        shape: const Border(bottom: BorderSide(width: 1)),
        actions: [TextButton(onPressed: () {}, child: const Text("Update"))],
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: ScreenHeight*0.06,
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [

                CircleAvatar(
                  radius: min(ScreenWidth * 0.25, ScreenHeight * 0.15),
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _image != null ? FileImage(File(_image!.path)) : null,
                  child: _image == null
                      ? const Icon(Icons.person, size: 80, color: Colors.grey)
                      : null,
                ),
                 Positioned(
                   right: ScreenWidth * 0.11, // Position it at the right edge of the circle
                   bottom: ScreenHeight * 0.01, // Position it at the middle height of the circle
                   child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.black)),
                        child: IconButton(
                          color: Colors.black,
                          icon: const Icon(
                              Icons.edit),
                          onPressed: () {
                            showDialogBox();

                          },
                        ),
                    ),
                 ),
              ],
            ),
            SizedBox(
              height: ScreenHeight*0.06,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenWidth * 0.1),
              child: Column(
                children: [
                  TextField(
                    controller: controllerName,
                    decoration: const InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                  ),
                  SizedBox(height: ScreenHeight * 0.01),
                  TextField(
                    controller: emailId,
                    decoration: const InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)))),
                  ),
                  SizedBox(height: ScreenHeight * 0.01),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white10,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UpdatePassword()));
                    },
                    child: const Text("Update the Password"),
                  ),
                  SizedBox(height: ScreenHeight * 0.01),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UpdatePassword()));
                    },
                    child: Text("Log Out"),
                  ),
                ],
              ),
            ),
          ],
                  ),
      ),
    );
  }
}
