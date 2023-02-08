import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:soneilcharging/helpers/timeZone.dart';

class timeZoneSelection extends StatefulWidget {
  const timeZoneSelection({Key? key}) : super(key: key);

  @override
  State<timeZoneSelection> createState() => _timeZoneSelectionState();
}

class _timeZoneSelectionState extends State<timeZoneSelection> {
  var sortedTimeZoneList = timeZone;

  void assignID() {
    timeZone.forEach((element) {
      String? smallString = element['label'];
      print(smallString);
    });
  }

  @override
  void initState() {
    assignID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
              itemCount: timeZone.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(timeZone[i]['label'].toString()),
                  onTap: () {
                    Navigator.pop(context, timeZone[i]);
                  },
                );
              })),
    );
  }
}
