import 'package:flutter/material.dart';

class Recording extends StatefulWidget {
  const Recording({Key? key}) : super(key: key);

  @override
  State<Recording> createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenHeight*0.2,
          ),
          Padding(

            padding: EdgeInsets.only(
                top: screenHeight * 0.05, left: screenWidth * 0.40),
            child: Row(
              children: [
                Container(
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xff0000000),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic_none_outlined),
                    iconSize: 48,
                  ),
                ),
                Container(
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xfffffffff),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.1),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                // primary: Colors.white,
                backgroundColor: Colors.black,
                // onSurface: Colors.grey,
              ),
              child: const Text(
                'Start New Recording',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
