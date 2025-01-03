import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_page/global_variable.dart';
import 'package:login_page/notes/models/create_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart ' as http;

class UpdateNotes {
  Future<Notes> fetchNoteById({
    required BuildContext context,
    required String noteId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      final res = await http.post(
        Uri.parse('$uri/api/notes/?noteId=$noteId'),
        headers: {'x-auth-token': token!},
      );

      if (res.statusCode == 200) {
        var jsonData = jsonDecode(res.body);
        var notesData = jsonData['allnotes'];
        final matchingNote = notesData.firstWhere(
          (note) => note['_id'] == noteId,
        );
        return Notes.fromMap(matchingNote);
      } else {
        throw Exception('Failed to fetch note');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Notes>> editNotes({
    required BuildContext context,
    required String title,
    required String content,
    required String date,
    String? userId,
    required String noteId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? user = prefs.getString('user');
      String? token = prefs.getString('x-auth-token');
      if (user != null) {
        Notes editNote = Notes(
          // _id:Noteid
          title: title,
          content: content,
          date: date,
          userId: userId ?? '',
          noteId: noteId,
        );
        http.Response res = await http.put(Uri.parse('$uri/api/noteupdate'),
            body: editNote.toJson(),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token!,
            });
        if (res.statusCode == 200) {
          var jsonData = json.decode(res.body);
          print(jsonData);
          var notesData = jsonData['allNotes'];
          if (notesData != null && notesData is List) {
            List<Notes> updatedNotes = notesData
                .where((updatedNote) => updatedNote is Map<String, dynamic>)
                .map<Notes>((updatedNote) =>
                    Notes.fromMap(updatedNote as Map<String, dynamic>))
                .toList();
            return updatedNotes;
          }
          const SnackBar(content: Text('note updated sucessfully'));
        } else {
          const SnackBar(content: Text('note is not updated'));
        }
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
