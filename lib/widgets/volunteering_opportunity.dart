import 'package:flutter/material.dart';
import 'package:volunteeringnorthland/google-calender/calender_response.dart';
import 'package:volunteeringnorthland/google-calender/formatters.dart';

const _titleStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

class VolunteeringOpportunityWidget extends StatelessWidget {
  final CalenderEvent opportunity;

  const VolunteeringOpportunityWidget(this.opportunity, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        // Title text
        child: Text(
          opportunity.summary,
          style: _titleStyle,
          textAlign: TextAlign.center,
        ),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      ),
      // Time information
      Padding(
        child: Column(children: [
          const Padding(
            child: Icon(Icons.today),
            padding: EdgeInsets.only(bottom: 5),
          ),
          Column(children: [
            Text("Start: ${formatDate(opportunity.start)}"),
            Text("End:   ${formatDate(opportunity.end)}")
          ]),
        ]),
        padding: const EdgeInsets.only(left: 5),
      ),
      // Location
      Padding(
        child: Column(children: [
          const Padding(
            child: Icon(Icons.pin_drop),
            padding: EdgeInsets.only(bottom: 5),
          ),
          Text(opportunity.location)
        ]),
        padding: const EdgeInsets.only(top: 5),
      ),
      Padding(
        child: Column(children: [
          const Padding(
            child: Icon(Icons.repeat),
            padding: EdgeInsets.only(bottom: 5),
          ),
          ...opportunity.recurrence.map((e) => Text(e.toString()))
        ]),
        padding: const EdgeInsets.only(top: 5),
      )
    ]);
  }
}
