import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'widgets/main_app.dart';

void main() {
  tz.initializeTimeZones();
  runApp(const MainApp());
}

