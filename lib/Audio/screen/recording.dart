import 'dart:io';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:login_page/Audio/server/audio_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart'; // Add this package for playback

class Recording extends StatefulWidget {
  const Recording({Key? key}) : super(key: key);

  @override
  State<Recording> createState() => _RecordingState();
}

class _RecordingState extends State<Recording> {
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer(); // Add audio player
  bool isRecording = false;
  bool isPlaying = false;
  String? audioPath;

  @override
  void dispose() {
    audioRecorder.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.2,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.05,
              left: screenWidth * 0.1, // Adjusted for better spacing
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
              children: [
                // Record button
                Container(
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isRecording ? Colors.red : Colors.black,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      if (isRecording) {
                        await _stopRecording();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Recording Stopped")),
                        );
                      } else {
                        await _startRecording();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Recording Started")),
                        );
                      }
                    },
                    icon: Icon(
                      isRecording ? Icons.stop : Icons.mic,
                      color: Colors.white,
                    ),
                    iconSize: 48,
                  ),
                ),
                SizedBox(width: screenWidth * 0.05),
                // Play button (only enabled when recording is available)
                Container(
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: audioPath != null ? Colors.green : Colors.grey,
                  ),
                  child: IconButton(
                    onPressed: audioPath != null
                        ? () async {
                            if (isPlaying) {
                              await audioPlayer.stop();
                              setState(() {
                                isPlaying = false;
                              });
                            } else {
                              await audioPlayer
                                  .play(DeviceFileSource(audioPath!));
                              setState(() {
                                isPlaying = true;
                              });
                              // Listen for playback completion
                              audioPlayer.onPlayerComplete.listen((event) {
                                setState(() {
                                  isPlaying = false;
                                });
                              });
                            }
                          }
                        : null,
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    iconSize: 48,
                  ),
                ),
                SizedBox(width: screenWidth * 0.05),
                // Close button
                Container(
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.2,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close, color: Colors.white),
                    iconSize: 48,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.1),
            child: TextButton(
              onPressed: () async {
                if (isRecording) {
                  await _stopRecording();
                } else {
                  await _startRecording();
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                isRecording ? 'Stop Recording' : 'Start New Recording',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (audioPath != null)
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Recording saved at: ${audioPath!.split('/').last}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _startRecording() async {
    if (await audioRecorder.hasPermission()) {
      // Create a new file path for each recording
      final directory = await getApplicationDocumentsDirectory();
      audioPath =
          '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await audioRecorder.start(const RecordConfig(), path: audioPath!);
      setState(() {
        isRecording = true;
      });
    }
  }

  Future<void> _stopRecording() async {
    if (isRecording) {
      await audioRecorder.stop();
      setState(() {
        isRecording = false;
      });

      // Handle the recorded file
      await handleRecording(audioPath!);
      print("recording Habdel");
    }
  }

  Future<void> handleRecording(String filePath) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print('Offline: File saved locally at $filePath');
    } else {
      await AudioService()
          .addAudio(context: context, audioFile: File(audioPath!));
      print('Online: File saved at $filePath');
      // onlinesave.
      // You can add code here to upload the file to your server
      // For example: await uploadService.uploadAudio(filePath);
    }
  }
}
