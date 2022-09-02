import 'package:flutter/material.dart';

import '../helpers/constant.dart';
import 'package:intl/intl.dart';

class scheduleWidget extends StatefulWidget {
  const scheduleWidget({Key? key}) : super(key: key);

  @override
  State<scheduleWidget> createState() => _scheduleWidgetState();
}

class _scheduleWidgetState extends State<scheduleWidget>
    with AutomaticKeepAliveClientMixin<scheduleWidget> {
  @override
  bool get wantKeepAlive => true;

  String isString = "Yes";
  bool isAdded = true;

  List setTimes = [];

  void clearDepartList() {
    setState(() {
      isAdded = true;
      setTimes.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "All times cleared.",
        style: smallTexts,
      ),
      backgroundColor: Colors.blue,
      dismissDirection: DismissDirection.down,
      elevation: 10,
    ));
  }

  void departList(addedTime) {
    setState(() {
      isAdded = true;
      setTimes.add(addedTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              if (!isAdded) scheduleConfig(notifyParent: departList),
              if (isAdded)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Center(
                        child: FloatingActionButton(
                            splashColor: Colors.blue,
                            focusElevation: 10.0,
                            elevation: 10,
                            backgroundColor: Colors.blue.shade800,
                            child: Icon(Icons.add),
                            onPressed: (() => setState(() {
                                  isAdded = false;
                                }))),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "Add departure time.",
                        style: normalTexts,
                      )
                    ],
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              setDepartureWidget(
                  setTimes: setTimes, notifyParent: clearDepartList)
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
  TimeOfDay _time = TimeOfDay(hour: 12, minute: 00);
  TextEditingController depLabel = new TextEditingController();

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
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.shade900,
      child: Column(
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
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TextField(
                  controller: depLabel,
                  decoration: const InputDecoration(
                    hintText: 'Give name to your departure.',
                    labelText: 'Label',
                  ),
                ),
              ),
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
                            currentTime.addAll({
                              'time': _time,
                              'selectedDays': _selectedIndexs,
                              'label': depLabel.text.isNotEmpty
                                  ? depLabel.text
                                  : "Departure"
                            }),
                            widget.notifyParent(currentTime)
                          },
                      child: const Text("Save"))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

// this widget displays set departured times
class setDepartureWidget extends StatefulWidget {
  final List setTimes;
  final Function() notifyParent;
  const setDepartureWidget(
      {Key? key, required this.setTimes, required this.notifyParent})
      : super(key: key);

  @override
  State<setDepartureWidget> createState() => _setDepartureWidgetState();
}

class _setDepartureWidgetState extends State<setDepartureWidget> {
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
    if (widget.setTimes.isEmpty) {
      return Column(
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
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Set Departures",
                style: tableTitle,
              ),
              InkWell(
                onTap: (() => {
                      widget.notifyParent(),
                    }),
                child: const Text("Clear All",
                    style: TextStyle(color: Colors.blueAccent)),
              )
            ],
          ),
          Divider(
            height: 20,
            color: Colors.blue.shade800,
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: widget.setTimes.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                title: Text(widget.setTimes[index]['label']),
                trailing: Text(widget.setTimes[index]['time'].format(context)),
                children: [
                  Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        for (var elem in widget.setTimes[index]['selectedDays'])
                          weekCheckboxes(elem)
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  /* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () => {}, child: const Text("Save"))
                  ],
                ) */
                ],
              );
            },
          ),
        ],
      );
    }
  }
}
