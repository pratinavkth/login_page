import 'package:flutter/material.dart';
import 'package:login_page/Audio/models/audio_model.dart';
import 'package:login_page/Audio/screen/audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioService{
  Future<void>addAudio({
    required BuildContext context
    // required 

  })async{
    try{
      SharedPreferences prefs =await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if(token!= null){
        Audios uploadAudio = Audios(
          fileName: '',
          filePath: '',
          format: '',
          duration: '',
          uploadedAt: '',
        );


      } 

    }
    catch(e){

    }
  }
}