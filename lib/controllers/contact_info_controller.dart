import 'package:get/get.dart';
import 'package:orbitwork/models/user_model.dart';

class ContactInfoController extends GetxController{
  final Rx<UsersModel> user = UsersModel(firstName: '',lastName: '', email: '', userId: '', timeZone: '',
      city: '', state: '', pinCode: '', country: '', phone: '', address: '', address2: '').obs;

  var isEditingAccount = false.obs;
  var isEditingLocation = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    user.value = UsersModel(
        firstName:'John', lastName: 'Doe', email: 'j*****12@gmail.com', userId: 'user123',
        timeZone: 'UTC+05:30 Mumbai, Kolkata, Chennai, New DElhi',
        city: 'Rajkot', state: 'GJ', pinCode: '360005', country: 'India', phone: '+91 1234567890',
        address: 'Rajkot', address2: '');
  }
}