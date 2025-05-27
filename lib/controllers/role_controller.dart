import 'package:get/get.dart';

import '../enum/user_role_enum.dart';

class RoleController extends GetxController{
  Rx<UserRole?> selectedRole = Rx<UserRole?>(null);

  void selectRole(UserRole? role) {
    selectedRole.value = role;
  }
}