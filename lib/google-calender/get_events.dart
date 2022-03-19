import 'dart:convert';

import 'package:http/http.dart';
import 'package:timezone/timezone.dart';
import 'package:volunteeringnorthland/google-calender/calender_response.dart';

const _weekdayMap = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];

Future<Map<String, List<CalenderEvent>>> getEvents(String calenderId, String key) async {
  var location = getLocation("Pacific/Auckland");
  var now = TZDateTime.now(location).add(const Duration(days:  -1));
  var later = now.add(const Duration(days: 9));
  var url = Uri.parse(
      "https://www.googleapis.com/calendar/v3/calendars/$calenderId/events?key=$key&timeMin=${now.toUtc().toIso8601String()}&timeMax=${later.toUtc().toIso8601String()}"
  );
  var res = await get(url);

  if (res.statusCode != 200) {
    throw Exception("Non-success status code\n${res.body}");
  }

  var body = jsonDecode(res.body);
  var items = CalenderResponse.fromJson(body);

  Map<String, List<CalenderEvent>> grouped = {};

  for (var item in items.events) {
    var wkday = _weekdayMap[item.start.weekday - 1];

    if (grouped[wkday] == null) {
      grouped[wkday] = [item];
    } else {
      grouped[wkday]!.add(item);
    }
  }

  for (var day in grouped.keys) {
    grouped[day]!.sort((a, b) => a.start.compareTo(b.start));
  }

  return grouped;
}
