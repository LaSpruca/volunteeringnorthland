import 'package:timezone/timezone.dart';

class CalenderResponse {
  final List<CalenderEvent> events;

  const CalenderResponse({required this.events});

  factory CalenderResponse.fromJson(Map<String, dynamic> map) {
    return CalenderResponse(
        events: List<CalenderEvent>.from(
            map["items"].map((e) => CalenderEvent.fromJson(e))));
  }
}

class CalenderEvent {
  final TZDateTime start;
  final TZDateTime end;
  final String htmlLink;
  final String summary;
  final String location;
  final List<Recurrence> recurrence;

  CalenderEvent(
      {required this.start,
      required this.end,
      required this.htmlLink,
      required this.summary,
      required this.location,
      required this.recurrence});

  factory CalenderEvent.fromJson(Map<String, dynamic> map) {
    return CalenderEvent(
        start: _parseDate(map["start"]),
        end: _parseDate(map["end"]),
        htmlLink: map["htmlLink"],
        summary: map["summary"],
        location: map["location"],
        recurrence: _getRecurrence(map["recurrence"]));
  }
}

TZDateTime _parseDate(Map<String, dynamic> map) {
  var tz = map["timeZone"];
  var date = map["dateTime"];

  return TZDateTime.parse(getLocation(tz), date);
}

class Recurrence {
  final Frequency frequency;
  final int interval;
  final String byDay;

  const Recurrence(
      {required this.frequency, required this.interval, required this.byDay});

  factory Recurrence.fromString(String input) {
    var frequency = Frequency.weekly;
    var interval = 1;
    var byDay = "Monday";

    for (var line in input.split(":")[1].split(";").map((e) => e.split("="))) {
      switch (line[0]) {
        case "FREQ":
          switch (line[1]) {
            case "DAILY":
              frequency = Frequency.daily;
              break;
            case "WEEKLY":
              frequency = Frequency.weekly;
              break;
            case "YEARLY":
              frequency = Frequency.yearly;
              break;
            case "MONTHLY":
              frequency = Frequency.monthly;
              break;
            default:
              break;
          }
          break;
        case "INTERVAL":
          interval = int.parse(line[1]);
          break;
        case "BYDAY":
          switch (line[1]) {
            case "MO":
              byDay = "Monday";
              break;
            case "TU":
              byDay = "Tuesday";
              break;
            case "WE":
              byDay = "Wednesday";
              break;
            case "TH":
              byDay = "Thursday";
              break;
            case "FR":
              byDay = "Friday";
              break;
            case "SA":
              byDay = "Sunday";
              break;
            case "SU":
              byDay = "Sunday";
              break;
            default:
              break;
          }
          break;
        default:
          break;
      }
    }

    return Recurrence(frequency: frequency, interval: interval, byDay: byDay);
  }

  @override
  String toString() {
    var freq = "";
    if (interval == 1) {
      switch (frequency) {
        case Frequency.daily:
          freq = "Daily";
          break;
        case Frequency.monthly:
          freq = "Monthly";
          break;
        case Frequency.weekly:
          freq = "Weekly";
          break;
        case Frequency.yearly:
          freq = "Yearly";
          break;
      }
    } else {
      freq = "Every $interval";

      var last = interval.floor() % 10;

      switch (last) {
        case 1:
          freq += "st";
          break;
        case 2:
          freq += "nd ";
          break;
        case 3:
          freq += "rd ";
          break;
        default:
          break;
      }

      switch (frequency) {
        case Frequency.daily:
          freq += "Day";
          break;
        case Frequency.monthly:
          freq += "Month";
          break;
        case Frequency.weekly:
          freq += "Week";
          break;
        case Frequency.yearly:
          freq += "Year";
          break;
      }
    }

    return "$freq on $byDay";
  }
}

enum Frequency { daily, weekly, monthly, yearly }


List<Recurrence> _getRecurrence(List<dynamic> inputs) {
  List<Recurrence> list = [];

  for (var item in inputs) {
    list.add(Recurrence.fromString(item.toString()));
  }

  return list;
}