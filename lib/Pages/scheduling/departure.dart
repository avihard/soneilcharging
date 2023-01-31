import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Animation/FunkyAnimation.dart';
import '../../helpers/SnapSlider.dart';
import '../../helpers/constant.dart';
import '../../helpers/utils.dart';

//saving into the local file of the device
void saveScheduleTime(setTimes) {
  List tempSetTimes = [];
  final now = new DateTime.now();

  tempSetTimes = setTimes
      .map((e) => {
            "id": e['id'],
            //'selectedDays': e['selectedDays'],
            'label': e['label'],
            'date': e['date'],
            'maxHrs': e['maxHrs'],
            'current': e['current'],
            'time': DateTime(now.year, now.month, now.day, e['time'].hour,
                    e['time'].minute)
                .toIso8601String()
          })
      .toList();

  /* for (var i = 0; i < tempSetTimes.length; i++) {
    tempSetTimes[i]['time'] = DateTime(now.year, now.month, now.day,
            setTimes[i]['time'].hour, setTimes[i]['time'].minute)
        .toIso8601String();

    tempSetTimes[i]['label'] = setTimes[i]['label'] + "_1";
  } */

  final jsonStr = jsonEncode(tempSetTimes);
  // writing the saved vehicle data to localfile
  writeCounter("scheduleCharging.txt", jsonStr);
}

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

  // reading from localfile
  void readScheduleTime() async {
    String jsonStr = await readCounter("scheduleCharging.txt");

    List tempList = jsonDecode(jsonStr);

    tempList = tempList
        .map((e) => {
              "id": e['id'],
              //'selectedDays': e['selectedDays'],
              'date': e['date'],
              'label': e['label'],
              'maxHrs': e['maxHrs'],
              'current': e['current'],
              'time': TimeOfDay(
                  hour: DateTime.parse(e['time']).hour,
                  minute: DateTime.parse(e['time']).minute)
            })
        .toList();

    setState(() {
      setTimes = tempList;
    });

    // reading from file and setting our local map to it

    //addedVehicles = jsonDecode(jsonStr);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // read from file
    readScheduleTime();
  }

  void clearDepartList() {
    setState(() {
      isAdded = true;
      setTimes.clear();
    });
    saveScheduleTime(setTimes);
    showSnackBar(context, "All times cleared.");
  }

  String setScheduleTime() {
    var dayString = '';
    // convert day to day index
    for (var index = 0; index < setTimes.length; index++) {
      var minutes =
          setTimes[index]['time'].hour * 60 + setTimes[index]['time'].minute;
      for (var j = 0; j < setTimes[index]['selectedDays'].length; j++) {
        if (setTimes[index]['selectedDays'][j]['values']) {
          var dayScheduled =
              j.toString() + "_" + minutes.toString() + "_" + "10";

          dayString +=
              dayString.length != 0 ? ";" + dayScheduled : dayScheduled;
        }
      }
    }

    return dayString;
  }

  String createJsonData(addedTime) {
    String scheduleString = setScheduleTime();

    var data = {
      'ScheduleTime': scheduleString,
      'TimeZone': addedTime['timeZone']
    };

    // API call here
    // create data in format
    String dataString = jsonEncode(data);

    return dataString;
  }

  void departList(addedTime) {
    var isConflicting = false;
    // get all the elements of the same date which has been already scheduled previously.
    var checkTimes = setTimes.where(
      (element) {
        return element['date'] == addedTime['date'];
      },
    );

    for (var element in checkTimes) {
      var setMinutes = element['time'].hour * 60 + element['time'].minute;
      var toSetMinutes = addedTime['time'].hour * 60 + addedTime['time'].minute;

      if (setMinutes == toSetMinutes) {
        isConflicting = true;
        FunkyNotification(
            error:
                "Your time is matching exactly with some other scheduled time.");
      } else if ((setMinutes - 30) <= toSetMinutes &&
          toSetMinutes <= (setMinutes + 30)) {
        isConflicting = true;
        FunkyNotification(error: "Your time is in range with other time.");
      }
    }

    if (!isConflicting) {
      setState(() {
        isAdded = true;
        setTimes.add(addedTime);
      });

      // API call here
      // create data in format
      //String dataString = createJsonData(addedTime);

      saveScheduleTime(setTimes);
    }
  }

  void deleteElement(id) {
    setState(() {
      setTimes.removeWhere((element) => element['id'] == id);
    });
    saveScheduleTime(setTimes);
  }

  void saveElement(addedTime) {
    setState(() {
      isAdded = true;
    });

    // API call here
    // create data in format
    // String dataString = createJsonData(addedTime);

    saveScheduleTime(setTimes);
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

  // max charging hr controller
  TextEditingController maxHrs = new TextEditingController(text: "10");

  TextEditingController dateInput = TextEditingController();

  Map<String, dynamic> currentTime = {};

  Key sliderKey = const Key("scheduleKey");
  double _currvalue = 32.0;

  final List _selectedIndexs = [
    {
      "values": false,
      "text": "Sun",
    },
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

  void slideUpdateValue(value) {
    setState(() {
      _currvalue = value;
    });
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: dateInput,
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dateInput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
              ),
              /* Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    for (var elem in _selectedIndexs) weekCheckboxes(elem)
                  ]), */
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: SnapSlider(
                  sliderKey: sliderKey,
                  snapValues: {10.0, 16.0, 20.0, 24.0, 32.0},
                  value: _currvalue,
                  min: 10.0,
                  max: 32.0,
                  label: "Current",
                  textColor: Colors.white,
                  activeColor: Colors.white,
                  isArrows: false,
                  updateValue: slideUpdateValue,
                ), /* TextField(
                  controller: maxHrs,
                  decoration: const InputDecoration(
                    hintText: 'Max charging hours.',
                    labelText: 'Max Charge Hours',
                  ),
                ) */
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
                              'date': dateInput.text,
                              //'selectedDays': _selectedIndexs,
                              'maxHrs': /* maxHrs.text.isNotEmpty
                                  ? double.parse(maxHrs.text)
                                  :  */
                                  10.0,
                              'current': _currvalue,
                              'label': depLabel.text.isNotEmpty
                                  ? depLabel.text
                                  : "Departure",
                              //'timeZone': DateTime.now().timeZoneName
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
  final Function(Map) saveElement;
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

  //TextEditingController maxHrs = new TextEditingController(text: );
  List<TextEditingController> textControllers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    textControllers = [];
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
              textControllers.add(new TextEditingController(
                  text: widget.setTimes[index]['date'].toString()));
              return ExpansionTile(
                //initiallyExpanded: selected,
                //key: GlobalKey(),
                title: Text(widget.setTimes[index]['label']),
                trailing: Text(widget.setTimes[index]['time'].format(context)),
                onExpansionChanged: (value) {
                  return value ? _selectTime(index) : null;
                },
                children: [
                  StatefulBuilder(builder: ((context, setState) {
                    return TextField(
                      controller: textControllers[index],
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter Date" //label text of field
                          ),
                      readOnly: true,
                      onTap: () async {
                        /* DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateFormat("yyyy-MM-dd")
                                .parse(textControllers[index].text),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            textControllers[index].text = formattedDate;
                          });
                        } else {} */
                      },
                    );
                  })),
                  /* Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        for (var elem in widget.setTimes[index]['selectedDays'])
                          weekCheckboxes(elem)
                      ]), */
                  const SizedBox(
                    height: 5,
                  ),
                  SnapSlider(
                      snapValues: {10, 16, 20, 24, 32},
                      value: widget.setTimes[index]['current'],
                      min: 10.0,
                      max: 32.0,
                      label: "Current",
                      textColor: Colors.white,
                      activeColor: Colors.white,
                      isArrows: false,
                      updateValue: (value) {
                        setState(() {
                          widget.setTimes[index]['current'] = value;
                        });
                      }),
                  /* TextField(
                    controller: textControllers[index],
                    decoration: const InputDecoration(
                      hintText: 'Max charging hours.',
                      labelText: 'Max Charge Hours',
                    ),
                  ), */
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          widget.setTimes[index]['date'] =
                              textControllers[index].text;
                          // here we will call API to save the data
                          widget.saveElement(widget.setTimes[index]);
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
