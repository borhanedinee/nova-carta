import 'package:intl/intl.dart';

formattedDateTime(DateTime date) {
  DateFormat formattedForm = DateFormat('d MMMM \n HH:mm');
  return formattedForm.format(date);
}
