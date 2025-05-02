import 'dart:io';
import 'package:flutter/material.dart';
import 'package:orbitwork/models/upload_file_model.dart';
import 'package:path_provider/path_provider.dart';

extension UploadFileUtils on UploadFile{
  Future<bool> isFileDownloadedLocally() async{
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$name';
    return File(path).exists();
  }
}
