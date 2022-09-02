import 'package:flutter/material.dart';

import '../helpers/constant.dart';
import 'package:intl/intl.dart';

class scheduleWidget extends StatefulWidget {
  const scheduleWidget({Key? key}) : super(key: key);

  @override
  State<scheduleWidget> createState() => _scheduleWidgetState();
}

class _scheduleWidgetState extends State<scheduleWidget> {
  String isString = "Yes";

  List setTimes = [];

  void departList(addedTime) {
    setState(() {
      setTimes.add(addedTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Schedule Charging",
                style: headerText,
              ),
              scheduleConfig(notifyParent: departList),
              const SizedBox(
                height: 20,
              ),
              setDepartureWidget(setTimes: setTimes)
            ],
          ),
        ),
      ),
    );
  }
}

class scheduleConfig extends StatefulWidget {
  final Function(Map) notifyParent;
  const scheduleConfig({Key? key, required this.notifyParent})
      : super(key: key);

  @override
  State<scheduleConfig> createState() => _scheduleConfigState();
}

class _scheduleConfigState extends State<scheduleConfig> {
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  Map<String, dynamic> currentTime = {};

  final List _selectedIndexs = [
    {
      "values": false,
      "text": "Mon",
    },
    {
      "values": false,
      "text": "Tue",
    },
    {
      "values": false,
      "text": "Wed",
    },
    {
      "values": false,
      "text": "Thur",
    },
    {
      "values": false,
      "text": "Fri",
    },
    {
      "values": false,
      "text": "Sat",
    },
    {
      "values": false,
      "text": "Sun",
    }
  ];

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  Widget weekCheckboxes(elem) {
    return Container(
      width: 50,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            width: 50,
            child: Text(
              elem['text'],
              textAlign: TextAlign.center,
            ),
          ),
          Checkbox(
              activeColor: Colors.blue.shade800,
              value: elem['values'],
              onChanged: (value) => {
                    setState(
                      () => {elem['values'] = value},
                    )
                  })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          title: const Text("Departure Time"),
          trailing: Text(_time.format(context)),
          onExpansionChanged: (value) {
            return value ? _selectTime() : null;
          },
          children: [
            Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  for (var elem in _selectedIndexs) weekCheckboxes(elem)
                ]),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => {
                          // format the data and pass it to parent.
                          currentTime.addAll(
                              {'time': _time, 'selectedDays': _selectedIndexs}),
                          widget.notifyParent(currentTime)
                        },
                    child: const Text("Save"))
              ],
            )
          ],
        ),
      ],
    );
  }
}

// this widget displays set departured times
class setDepartureWidget extends StatefulWidget {
  final List setTimes;
  const setDepartureWidget({Key? key, required this.setTimes})
      : super(key: key);

  @override
  State<setDepartureWidget> createState() => _setDepartureWidgetState();
}

class _setDepartureWidgetState extends State<setDepartureWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.setTimes.isEmpty) {
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Set Departures",
            style: tableTitle,
          ),
          Divider(
            color: Colors.blue.shade800,
            height: 20,
          ),
          Text("You have no departure time set yet.")
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Set Departures",
          style: tableTitle,
        ),
        Divider(
          height: 20,
          color: Colors.blue.shade800,
        ),
        const Text("Soon displaying...")
      ],
    );
  }
}
