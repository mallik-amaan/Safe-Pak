import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

Future<String> uploadFile(File file)async{
  final supabase = Supabase.instance.client;

  try {
    Uuid uuid = Uuid();
    // Generate a unique file ID
    String fileName = file.path.split('/').last;
    String fileId = '${uuid.v1()}_$fileName';
    final response = await supabase.storage.from('uploads').upload(fileId, file);
    print('File uploaded: $response');
    final fileUrl = supabase.storage.from('uploads').getPublicUrl(fileId);
    print('File URL: $fileUrl');
    return fileUrl;
  } catch (e) {
    throw Exception('Error uploading file');
  }
}