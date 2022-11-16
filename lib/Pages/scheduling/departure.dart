import 'package:flutter/material.dart';
import '../../helpers/constant.dart';

class departureWidget extends StatefulWidget {
  const departureWidget({Key? key}) : super(key: key);

  @override
  State<departureWidget> createState() => _departureWidgetState();
}

class _departureWidgetState extends State<departureWidget>
    with AutomaticKeepAliveClientMixin<departureWidget> {
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

  void deleteElement(id) {
    setState(() {
      setTimes.removeWhere((element) => element['id'] == id);
    });
  }

  void saveElement(id) {
    setState(() {
      isAdded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    hoverColor: Colors.blue,
                    focusColor: Colors.blue,
                    child: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 32,
                    ),
                    onTap: () => {Navigator.pop(context)},
                  ),
                  Text(
                    "Schedule Charging",
                    style: headerText,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, top: 8),
                child: Text(
                  "Create schedule to charge your car. Charging will automatically start if the car is plugged in during this time.",
                  style: TextStyle(color: Colors.grey),
                ),
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
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: (() => setState(() {
                                  isAdded = false;
                                }))),
                      ),
                      const SizedBox(
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
                  setTimes: setTimes,
                  notifyParent: clearDepartList,
                  deleteElement: deleteElement,
                  saveElement: saveElement)
            ],
          ),
        ),
      ),
    ));
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
                              'id': UniqueKey().hashCode,
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
  final Function(dynamic) deleteElement;
  final Function(dynamic) saveElement;
  const setDepartureWidget(
      {Key? key,
      required this.setTimes,
      required this.notifyParent,
      required this.deleteElement,
      required this.saveElement})
      : super(key: key);

  @override
  State<setDepartureWidget> createState() => _setDepartureWidgetState();
}

class _setDepartureWidgetState extends State<setDepartureWidget> {
  bool selected = false;

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

  void _selectTime(index) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: widget.setTimes[index]['time'],
    );
    if (newTime != null) {
      setState(() {
        widget.setTimes[index]['time'] = newTime;
      });
    }
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
          const Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              "This shows all the departure time you have set till now.",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: widget.setTimes.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                initiallyExpanded: selected,
                key: GlobalKey(),
                title: Text(widget.setTimes[index]['label']),
                trailing: Text(widget.setTimes[index]['time'].format(context)),
                onExpansionChanged: (value) {
                  selected = value;
                  return value ? _selectTime(index) : null;
                },
                children: [
                  Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        for (var elem in widget.setTimes[index]['selectedDays'])
                          weekCheckboxes(elem)
                      ]),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selected = !selected;
                          });
                          // here we will call API to save the data
                          // widget.saveElement(widget.setTimes[index]['id']);
                        },
                        child: const Text("Save"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          widget.deleteElement(widget.setTimes[index]['id']);
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  )
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
