import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:orbitwork/repository/api/api_constants.dart';
import 'dart:convert';
import '../global/tokenStorage.dart';
import '../models/upload_file_model.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class UploadFileController extends GetxController {
  var isLoading = false.obs;
  var uploadedFile = Rxn<UploadFile>();

  // Pick file from gallery or camera
  // Future<void> pickAndUploadFile() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     File file = File(pickedFile.path);
  //     await uploadFile(file);
  //   }
  // }

  Future<UploadFile?> uploadFile(File file) async {
    try {
      isLoading.value = true;
      String? token = await TokenStorage.getToken();

      var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.UPLOAD_FILE));
      request.headers['Authorization'] = '$token';
      request.headers['Content-Type'] = 'multipart/form-data';

      var fileMimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
      request.files.add(await http.MultipartFile.fromPath(
          'files',
          file.path,
        contentType: MediaType.parse(fileMimeType),
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print('status code : ${response.statusCode}');
      print('response ::::: ${response.body}');
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        uploadedFile.value = UploadFile.fromJson(jsonResponse);
        Get.snackbar("Success", "File uploaded successfully!");
        return uploadedFile.value;  // ✅ Return uploaded file
      } else {
        Get.snackbar("Error", "File upload failed!");
        return null;  // ✅ Return null on failure
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar("Error", "Exception: $e");
      return null;  // ✅ Return null in case of an exception
    } finally {
      isLoading.value = false;
      if (file.existsSync()) {
        try {
          await file.delete();
        } catch (e) {
          print("Failed to delete temp file: $e");
        }
      }
    }
  }


  // Upload file API call
  // Future<void> uploadFile(File file) async {
  //   try {
  //     isLoading.value = true;
  //     String? token = await TokenStorage.getToken();
  //
  //     var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.UPLOAD_FILE));
  //     request.headers['Authorization'] = '$token';
  //     request.files.add(await http.MultipartFile.fromPath('files', file.path));
  //
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //
  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.decode(response.body);
  //       uploadedFile.value = UploadFile.fromJson(jsonResponse);
  //       Get.snackbar("Success", "File uploaded successfully!");
  //     } else {
  //       Get.snackbar("Error", "File upload failed!");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Exception: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
