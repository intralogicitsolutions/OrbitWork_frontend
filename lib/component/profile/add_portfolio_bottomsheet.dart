import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orbitwork/controllers/profile/add_portfolio_controller.dart';

import '../../widgets/characterLimited_textfeild.dart';
import '../../widgets/dotted_border_container_rectangle.dart';
import '../../widgets/text_editor_view.dart';
import '../../widgets/web_link_dialog.dart';

class AddPortfolioBottomsheet extends StatelessWidget{
  final AddPortfolioController controller = Get.put(AddPortfolioController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController skillController = TextEditingController();

  // void _showTextEditor() {
  //   final textEditorController = Get.put(AddPortfolioController());
  //   textEditorController.toggleTextEditor();
  // }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('Add a new portfolio project', style: TextStyle(
                      fontSize: 24,fontWeight: FontWeight.w500
                    ),),
                  ),
                  IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.close)),
                ],
              ),
              Text('All fields are required unless otherwise indicated.'),
              SizedBox(height: 24,),
              Text('Project title'),
              SizedBox(height: 5,),
              CharacterLimitedTextField(
                controller: titleController,
                remainingCharacters: controller.remainingTitleCharacters,
                maxCharacters: controller.maxTitleCharacters,
                onChanged: controller.updateTitleCharacterCount,
                hintText: 'Enter a brief but descriptive title',
              ),
              SizedBox(height: 16),
              Text('Your role (optional)'),
              SizedBox(height: 5,),
              CharacterLimitedTextField(
                controller: roleController,
                remainingCharacters: controller.remainingRoleCharacters,
                maxCharacters: controller.maxRoleCharacters,
                onChanged: controller.updateRoleCharacterCount,
                hintText: 'e.g.,Front-end engineer or Marketing analyst',
              ),
              SizedBox(height: 16),

              Text('Project description'),
              SizedBox(height: 5,),
              CharacterLimitedTextField(
                controller: descriptionController,
                remainingCharacters: controller.remainingDescriptionCharacters,
                maxCharacters: controller.maxDescriptionCharacters,
                onChanged: controller.updateDescriptionCharacterCount,
                hintText: 'Briefly describe the project\'s goals, your solution and the impact you made here',
              ),
              SizedBox(height: 16),

              Text('Skills and deliverables'),
              SizedBox(height: 5,),
              CharacterLimitedTextField(
                controller: skillController,
                remainingCharacters: controller.remainingSkillCharacters,
                maxCharacters: controller.maxSkillCharacters,
                onChanged: controller.updateSkillCharacterCount,
                hintText: 'Type to add skills relevant to this project',
              ),
              SizedBox(height: 24),
               TextEditorView(),
              _buildContentActions(),
              // SizedBox(height: 24),
              // Obx(() => TextEditorView()),
              SizedBox(height: 24),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  void _showTextEditor() {
    controller.toggleTextEditor();
  }

  // void _showWebLinkDialog() {
  //   Get.dialog(
  //     WebLinkDialog(),
  //     barrierDismissible: false,
  //   ).then((value) {
  //     if (value != null) {
  //       // Handle the added link
  //       print('Added link: $value');
  //     }
  //   });
  // }

  void _showWebLinkBottomSheet() {
    Get.bottomSheet(
      WebLinkBottomSheet(),
      isScrollControlled: true,
      ignoreSafeArea: false,
    ).then((value) {
      if (value != null) {
        // Handle the added link
        print('Added link: $value');
      }
    });
  }



  // Widget _buildContentActions() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey.shade300),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             _buildActionButton(
  //               icon: Icons.image,
  //               label: 'Image',
  //               onTap: () => _showImagePickerOptions(),
  //             ),
  //             _buildActionButton(
  //               icon: Icons.videocam,
  //               label: 'Video',
  //               onTap: () => controller.pickImage(ImageSource.gallery),
  //             ),
  //             _buildActionButton(
  //               icon: Icons.text_fields,
  //               label: 'Text',
  //               onTap: () {_showTextEditor();},
  //             ),
  //             _buildActionButton(
  //               icon: Icons.link,
  //               label: 'Link',
  //               onTap: () {_showWebLinkBottomSheet();},
  //             ),
  //             _buildActionButton(
  //               icon: Icons.file_present,
  //               label: 'File',
  //               onTap: () => controller.pickDocument(),
  //             ),
  //             _buildActionButton(
  //               icon: Icons.music_note,
  //               label: 'Music',
  //               onTap: () => controller.pickAudio(),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 8),
  //         Text('Add content'),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildContentActions() {
    return DottedBorderContainerRectangle(
      onTap: () {
        // Define what happens when the container is tapped, if needed
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: Icons.image,
                  label: 'Image',
                  onTap: () => _showImagePickerOptions(),
                ),
                _buildActionButton(
                  icon: Icons.videocam,
                  label: 'Video',
                  onTap: () => controller.pickImage(ImageSource.gallery),
                ),
                _buildActionButton(
                  icon: Icons.text_fields,
                  label: 'Text',
                  onTap: () {_showTextEditor();},
                ),
                _buildActionButton(
                  icon: Icons.link,
                  label: 'Link',
                  onTap: () {_showWebLinkBottomSheet();},
                ),
                _buildActionButton(
                  icon: Icons.file_present,
                  label: 'File',
                  onTap: () => controller.pickDocument(),
                ),
                _buildActionButton(
                  icon: Icons.music_note,
                  label: 'Music',
                  onTap: () => controller.pickAudio(),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('Add content'),
          ],
        ),
      ),
    );
  }


  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: Icon(icon, size: 20),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            child: Text('Save as draft', style: TextStyle(
              color: Colors.green
            ),),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide.none,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Preview', style: TextStyle(
              color: Colors.white
            ),),
          ),
        ),
      ],
    );
  }

  void _showImagePickerOptions() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                Get.back();
                controller.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
    );
  }
}