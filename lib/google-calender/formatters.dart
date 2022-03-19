import 'package:jiffy/jiffy.dart';
import 'package:timezone/timezone.dart';
import 'package:volunteeringnorthland/google-calender/calender_response.dart';

String formatDate(TZDateTime dateTime) {
  return Jiffy(dateTime).format("EEEE dd, MM yyyy HH:MM");
}
