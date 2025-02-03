import 'package:get/get.dart';

import '../models/membership_model.dart';

class MembershipController extends GetxController {
  final membership = Rx<Membership>(
    Membership(
      planName: 'Freelancer Plus Annual',
      cycleStartDate: DateTime(2024, 12, 26),
      cycleEndDate: DateTime(2025, 12, 25),
      connectsBalance: 126,
    ),
  );

  void changePlan() {
    print('Changing plan...');
  }

  void viewConnectsHistory() {
    print('Viewing connects history...');
  }

  String formatDateRange() {
    return '${_formatDate(membership.value.cycleStartDate)} — ${_formatDate(membership.value.cycleEndDate)}';
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
