import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
// import 'package:';

class Recording extends StatefulWidget {
  const Recording({Key? key}) : super(key: key);

  @override
  State<Recording> createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  final Record audioRecorder = Record();
  bool isRecording = false;
  String? audioPath;

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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color:  Color(0xFF0000000),
                  ),
                  child: IconButton(
                    onPressed: () async{
                      if(isRecording){
                        const Icon(Icons.stop,color: Colors.white,
                        );
                        await _stopRecording();
                      }
                      else if(!isRecording){
                        const Icon(Icons.play_arrow,color: Colors.white,);
                        await _startRecording();
                      }
                    },
                    icon: 
                    const Icon(Icons.mic_none_outlined,
                    color: Colors.white,
                    ),
                    iconSize: 48,
                  ),
                ),
                Container(
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.2,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color:  Color(0xFFFFFFFF),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.1),
            child: TextButton(
              onPressed: () async{
                if(isRecording){   
                  setState(() {
                    isRecording =false;
                  });
                }
                else{
                  if(await audioRecorder.hasPermission()){
                    final directory = await getApplicationDocumentsDirectory();
                    audioPath= '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
                    await audioRecorder.start(path: audioPath!); 
                    setState(() {
                      isRecording =true; 
                    });
                  }
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
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
  Future<void> handleRecording(String filePath)async{
    final connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.none){
      print('offline: File saved locally at $filePath');
    }else{
      // awai
    }
  }

  Future<void> _stopRecording()async{
    await audioRecorder.stop();
  }
  Future<void> _startRecording()async{
    await audioRecorder.start();
  }
  
}
