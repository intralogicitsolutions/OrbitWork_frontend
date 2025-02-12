import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPortfolioController extends GetxController{
  var maxTitleCharacters = 70;
  var remainingTitleCharacters = 70.obs;

  var maxRoleCharacters = 100;
  var remainingRoleCharacters = 100.obs;

  var maxDescriptionCharacters = 600;
  var remainingDescriptionCharacters = 600.obs;

  var maxSkillCharacters = 5;
  var remainingSkillCharacters = 5.obs;

  var selectedFiles = <File>[].obs;

  var isMarkdownMode = false.obs;
  var currentText = ''.obs;
  var heading = ''.obs;
  var isTextEditorVisible = false.obs;
  var selectedBlocks = <int>[].obs;

  var webLink = ''.obs;
  var isAddButtonEnabled = false.obs;

  void updateTitleCharacterCount(String text) {
    remainingTitleCharacters.value = maxTitleCharacters - text.length;
  }

  void updateRoleCharacterCount(String text) {
    remainingRoleCharacters.value = maxRoleCharacters - text.length;
  }

  void updateDescriptionCharacterCount(String text) {
    remainingDescriptionCharacters.value = maxDescriptionCharacters - text.length;
  }

  void updateSkillCharacterCount(String text) {
    remainingSkillCharacters.value = maxSkillCharacters - text.length;
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        selectedFiles.add(File(image.path));
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        selectedFiles.add(File(result.files.single.path!));
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick document: $e');
    }
  }

  Future<void> pickAudio() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );

      if (result != null) {
        selectedFiles.add(File(result.files.single.path!));
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick audio: $e');
    }
  }

  void toggleMarkdownMode() {
    isMarkdownMode.value = !isMarkdownMode.value;
  }

  void toggleTextEditor() {
    isTextEditorVisible.value = !isTextEditorVisible.value;
  }

  void moveBlockUp(int index) {
    // Implementation for moving text blocks up
  }

  void moveBlockDown(int index) {
    // Implementation for moving text blocks down
  }

  void deleteBlock(int index) {
    // Implementation for deleting text blocks
  }

  void updateWebLink(String link) {
    webLink.value = link;
    isAddButtonEnabled.value = link.trim().isNotEmpty;
  }

  void clearLink() {
    webLink.value = '';
    isAddButtonEnabled.value = false;
  }

  bool isValidUrl(String url) {
    // Basic URL validation
    return url.trim().isNotEmpty &&
        (url.startsWith('http://') || url.startsWith('https://'));
  }
}