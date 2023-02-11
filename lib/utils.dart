import 'package:intl/intl.dart';

String formatMessageDate(int messageDate) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(messageDate);
  DateFormat dateFormat = DateFormat('hh:mm a');
  return dateFormat.format(dateTime);
}
