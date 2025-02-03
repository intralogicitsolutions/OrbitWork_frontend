import 'package:get/get.dart';
import 'package:orbitwork/models/user_model.dart';

class ContactInfoController extends GetxController{
  final Rx<UserModel> user = UserModel(name: '', email: '', userId: '', timeZone: '',
      city: '', state: '', pinCode: '', country: '', phone: '').obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    user.value = UserModel(
        name:'John Doe', email: 'j*****12@gmail.com', userId: 'user123',
        timeZone: 'UTC+05:30 Mumbai, Kolkata, Chennai, New DElhi',
        city: 'Rajkot', state: 'GJ', pinCode: '360005', country: 'India', phone: '+91 1234567890');
  }
}