import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/widgets/step_indicator.dart';
import '../controllers/user_profile_controller.dart';
import '../views/createProfile/add_education.dart';
import '../views/createProfile/add_experience.dart';
import '../views/createProfile/add_languages.dart';
import '../views/createProfile/add_profile_title.dart';
import '../views/createProfile/photo_and_location.dart';
import '../views/createProfile/profile_creation_page.dart';
import '../views/createProfile/select_category.dart';
import '../views/createProfile/set_user_rate.dart';
import '../views/createProfile/skill_section.dart';
import '../views/createProfile/skill_section_page.dart';
import '../views/createProfile/write_an_overview.dart';
import 'custom_appbar.dart';

class CreateProfileContainer extends StatelessWidget{
  final ProfilesController controller = Get.put(ProfilesController());

  final List<Widget> steps = [
    ProfileCreationPage(),
    //SelectCategory(),
    SkillsSelectionScreen(),
    ProfileSkillView(),
    ProfileTitleView(),
    AddExperience(),
    AddEducation(),
    AddLanguages(),
    WriteAnOverview(),
    SetUserRate(),
    PhotoAndLocation(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isProfile: true,
        title: 'Create Your Profile',
        rightIcon:  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => steps[controller.currentProfileStep.value]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Obx(() => StepIndicator(
              currentStep: controller.currentProfileStep.value,
              totalSteps: controller.totalProfileSteps,
            )),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.green, size: 16,),
                  onPressed: () => controller.previousProfileStep(),
                ),
              ),
             // _buildBackButton(),
              Obx(
                 () {
                  return controller.currentProfileStep.value != 0 ? Row(
                    children: [
                      Obx(() => controller.currentProfileStep.value == 5 || controller.currentProfileStep.value == 6
                          ? TextButton(
                        child: const Text('Skip', style: TextStyle(color: Colors.green)),
                        onPressed: () => controller.nextProfileStep(),
                      )
                          : const SizedBox()),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                        ),
                        child: Obx(
                                () {
                              return Text(
                                _getButtonText(controller.currentProfileStep.value),
                                // controller.currentProfileStep.value == 2 ? 'Create Profile' : 'Save',
                                style: const TextStyle(color: Colors.white),
                              );
                            }
                        ),
                        onPressed: () => controller.nextProfileStep(),
                      ),
                    ],
                  ) : SizedBox.shrink();
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getButtonText(int step) {
    switch (step) {
      case 0:
      case 1:
        return 'Add Skills';
      case 2:
        return 'Add Profile Title';
      case 3:
        return 'Add Experience';
      case 4:
        return 'Add Education';
      case 5:
        return 'Add Language';
      case 6:
        return 'Write an Overview';
      case 7:
        return 'Set Your Role';
      case 8:
        return 'Photo and Location';
      case 9:
        return 'Review Your Profile';
      default:
        return 'Save';
    }
  }
}