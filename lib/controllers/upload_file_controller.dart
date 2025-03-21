import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:orbitwork/repository/api/api_constants.dart';
import 'dart:convert';
import '../global/tokenStorage.dart';
import '../models/upload_file_model.dart';

class UploadFileController extends GetxController {
  var isLoading = false.obs;
  var uploadedFile = Rxn<UploadFile>();

  // Pick file from gallery or camera
  Future<void> pickAndUploadFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      await uploadFile(file);
    }
  }

  // Upload file API call
  Future<void> uploadFile(File file) async {
    try {
      isLoading.value = true;
      String? token = await TokenStorage.getToken();

      var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.UPLOAD_FILE));
      request.headers['Authorization'] = '$token';
      request.files.add(await http.MultipartFile.fromPath('files', file.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        uploadedFile.value = UploadFile.fromJson(jsonResponse);
        Get.snackbar("Success", "File uploaded successfully!");
      } else {
        Get.snackbar("Error", "File upload failed!");
      }
    } catch (e) {
      Get.snackbar("Error", "Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
