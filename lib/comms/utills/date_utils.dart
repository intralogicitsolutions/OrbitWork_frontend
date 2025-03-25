import 'package:intl/intl.dart';

class DateUtilsHelper {
  static String formatDate(String apiDate) {
    DateTime parsedDate = DateTime.parse(apiDate);
    return DateFormat("MM/dd/yyyy").format(parsedDate);
  }
}
