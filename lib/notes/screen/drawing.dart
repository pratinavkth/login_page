import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

class Drawing extends StatefulWidget {
  const Drawing({Key? key}) : super(key: key);

  @override
  State<Drawing> createState() => _DrawingState();
}

class _DrawingState extends State<Drawing> {
  final DrawingController _drawingController = DrawingController();
  Color _currentColor = Colors.black;  // Store the current drawing color

  @override
  void initState() {
    super.initState();

    // Initial drawing style
    _drawingController.setStyle(
      color: _currentColor,                   
      strokeWidth: 5.0,                 
      strokeCap: StrokeCap.round,       
      strokeJoin: StrokeJoin.round,     
      isAntiAlias: true,                
      style: PaintingStyle.stroke,     
    );
  }

  // Function to change the drawing color
  void _changeColor(Color newColor) {
    setState(() {
      _currentColor = newColor;  
      _drawingController.setStyle(
        color: _currentColor,     
        strokeWidth: 5.0,         
        strokeCap: StrokeCap.round,
        strokeJoin: StrokeJoin.round,
        isAntiAlias: true,
        style: PaintingStyle.stroke,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Drawing Board",
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.circle, color: Colors.red),
                  onPressed: () => _changeColor(Colors.red),
                ),
                IconButton(
                  icon: const Icon(Icons.circle, color: Colors.green),
                  onPressed: () => _changeColor(Colors.green),
                ),
                IconButton(
                  icon: const Icon(Icons.circle, color: Colors.blue),
                  onPressed: () => _changeColor(Colors.blue),
                ),
                IconButton(
                  icon: const Icon(Icons.circle, color: Colors.yellow),
                  onPressed: () => _changeColor(Colors.yellow),
                ),
                IconButton(
                  icon: const Icon(Icons.circle, color: Colors.black),
                  onPressed: () => _changeColor(Colors.black),
                ),

              ],
            ),
          ),
          
          // Drawing board
          Expanded(
            child: DrawingBoard(
              controller: _drawingController,
              background: Container(

                height: screenHeight,
                width: screenWidth,
                color: const Color.fromARGB(255, 227, 221, 221), // Background color
              ),
              showDefaultActions: true,
              showDefaultTools: true,
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _getJsonList() async{
  print(const JsonEncoder.withIndent('').convert(_drawingController.getJsonList()));
}
}

