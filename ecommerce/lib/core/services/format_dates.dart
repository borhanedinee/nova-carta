import 'package:intl/intl.dart';

formattedDateTime_YYYYMMDD_HHMM(date) {
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm');
    return format.format(date);
  }