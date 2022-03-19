import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volunteeringnorthland/google-calender/calender_response.dart';
import 'package:volunteeringnorthland/google-calender/get_events.dart';
import 'package:volunteeringnorthland/widgets/splash_screen.dart';
import 'package:volunteeringnorthland/widgets/volunteering_opportunity_section.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _MainApp();
  }
}

class _MainApp extends StatefulWidget {
  const _MainApp({Key? key}) : super(key: key);

  @override
  State<_MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<_MainApp> {
  Map<String, List<CalenderEvent>>? events;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.red,
                accentColor: Colors.deepOrangeAccent)),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Volunteering Northland"),
          ),
          body: events == null
              ? const SplashScreen()
              : Scrollable(
                  viewportBuilder: (context, _) => Column(
                        children: [
                          ...events!.keys.map((day) =>
                              VolunteeringOpportunitySectionWidget(
                                  day, events![day]!)),
                          Padding(
                            child: ElevatedButton(
                                onPressed: () {
                                  _launchURL(
                                      "https://calendar.google.com/calendar/embed?src=c_2ovkk23r4ffhi6fk2pninnkh6g%40group.calendar.google.com&ctz=Pacific%2FAuckland");
                                },
                                child: const Text("View on Google Calender")),
                            padding: const EdgeInsets.only(top: 20),
                          ),
                        ],
                      )),
        ));
  }

  @override
  void initState() {
    super.initState();
    getEvents("c_2ovkk23r4ffhi6fk2pninnkh6g@group.calendar.google.com",
            "AIzaSyAia370fAWH5iQboCyMyxe6B3Ncp0XgEEk")
        .then((value) => {
              setState(() {
                events = value;
              })
            });
  }
}

void _launchURL(String _url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}
