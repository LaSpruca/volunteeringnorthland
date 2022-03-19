import 'package:flutter/material.dart';
import 'package:volunteeringnorthland/google-calender/calender_response.dart';
import 'package:volunteeringnorthland/widgets/volunteering_opportunity.dart';

const _headingTitle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold);

class VolunteeringOpportunitySectionWidget extends StatelessWidget {
  final String day;
  final List<CalenderEvent> opportunities;

  const VolunteeringOpportunitySectionWidget(this.day, this.opportunities,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(backgroundColor: Colors.deepOrangeAccent, title: Text(day)),
        ...opportunities.map((e) => Padding(
            child: VolunteeringOpportunityWidget(e),
            padding: const EdgeInsets.all(15)))
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
