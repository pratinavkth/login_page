import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_page/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:login_page/Audio/models/audio_model.dart';

class AudioService{
  Future<void>addAudio({
    required BuildContext context,
    required File audioFile,

    // required 

  })async{
    try{
      SharedPreferences prefs =await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if(token!= null){
        String fileName = audioFile.uri.pathSegments.last;
        String filepath = audioFile.path;
        String format = fileName.split('.').last;
        String uploadedAt = DateTime.now().toIso8601String();

        AudioPlayer player = AudioPlayer();
        await player.setSourceUrl(audioFile.path);
        Duration duration = await player.getDuration() ?? Duration.zero;
        String durationStr = _formatDuration(duration.inSeconds);

        // await player.openPlayer();
        var request = http.MultipartRequest(
          'POST',Uri.parse('$uri/api/audiorecord'));
          request.headers['x-auth-token']= token;
          request.files.add(await http.MultipartFile.fromPath('audio', audioFile.path));

          request.fields['filename']= fileName;
          request.fields['format']= format;
          request.fields['duration']= durationStr;
          request.fields['uploadedAt']= uploadedAt;
          request.fields['filePath'] = filepath;

       
        var res = await request.send();
        if(res.statusCode ==200){
          print('Audio uploaded successfully');
          const SnackBar(content:Text('Audio uploaded Succesfully') );
        }
        else{
          print('Error uploading audio');
          var responseData= await res.stream.bytesToString();
          SnackBar(content: Text("Error uploading Audio:$responseData"),);
        }
      } 
    }
    catch(e){
      print(e);
    }
  }

  String _formatDuration(int duration){
    int minutes = duration ~/ 60;
    int seconds = duration % 60;
    return '${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }

  Future<List<Audios>>fetchallAudio({
    required BuildContext context,
  })async{
    try{
      SharedPreferences pref =await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');
      String? userId = pref.getString('user');
      if(token!= null){
        Map<String,dynamic> bodyres={
          'userId':userId
          };
        http.Response res = await http.post(
          Uri.parse('$uri/api/allaudios'),
          body: json.encode(bodyres),
          headers: <String,String>{
            'Content-Type':'application/json',
            'x-auth-token':token,
          },
        );
        print(res.statusCode);
        if(res.statusCode == 200){
          var jsonData = jsonDecode(res.body);
          var audioData = jsonData['files'];
          if(audioData!= null){
            List<Audios> audios = audioData.
            where((audio)=> audio is Map<String,dynamic>).
            map<Audios>(
              (audio)=> Audios.fromMap(audio as Map<String,dynamic>)
            ).toList();
            return audios;
          }
        }
      }else{
        print('Error fetching audio');
      }
    }
    catch(e){
      print(e);
    }
    return [];

  }

  Future<void>deleteAudio({
    required BuildContext context,
  })async{
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      String?token = pref.getString('x-auth-token');
      if(token!=null){
        Map<String,dynamic>bodytodelete= {
          'fileId':token,
        };
        http.Response res = await http.delete(
          Uri.parse('$uri/api/audiodelete'),
          body: bodytodelete,
          headers: <String,String>{
            'Content-Type':'application/json',
            'x-auth-token':token,
          }
        );
        if(res.statusCode == 200){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Audio deleted successfully')));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete audio')));
        }
      }
    }
    catch(e){
      print(e);
    }
  }





}