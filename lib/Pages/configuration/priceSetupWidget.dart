import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';

import 'package:soneilcharging/Pages/configuration/commonStyle.dart';
import '../../helpers/constant.dart';
import '../../helpers/inputStyleWidget.dart';
import '../../helpers/utils.dart';

class PriceSetupWidget extends StatefulWidget {
  const PriceSetupWidget({Key? key}) : super(key: key);

  @override
  State<PriceSetupWidget> createState() => _PriceSetupWidgetState();
}

class _PriceSetupWidgetState extends State<PriceSetupWidget> {
  List? _selectedIndexs;

  ClockTimeFormat _clockTimeFormat = ClockTimeFormat.TWENTYFOURHOURS;
  final ClockIncrementTimeFormat _clockIncrementTimeFormat =
      ClockIncrementTimeFormat.ONEMIN;

  bool showForm = false;

  TextEditingController nameController = TextEditingController(text: "Peak");
  TextEditingController priceController = TextEditingController();

  PickedTime _startTime = PickedTime(h: 0, m: 0);
  PickedTime _endTime = PickedTime(h: 23, m: 59);

  PickedTime _intervalBedTime = PickedTime(h: 0, m: 0);

  PickedTime _disabledInitTime = PickedTime(h: 12, m: 0);
  PickedTime _disabledEndTime = PickedTime(h: 20, m: 0);

  bool isAdded = false;

  List peakList = [];

  // this maintains everything
  Map<dynamic, Map<String, List>> timeList = {
    0: {"startArr": [], "endArr": [], 'timeAddList': []},
    1: {"startArr": [], "endArr": [], 'timeAddList': []},
    2: {"startArr": [], "endArr": [], 'timeAddList': []},
    3: {"startArr": [], "endArr": [], 'timeAddList': []},
    4: {"startArr": [], "endArr": [], 'timeAddList': []},
    5: {"startArr": [], "endArr": [], 'timeAddList': []},
    6: {"startArr": [], "endArr": [], 'timeAddList': []},
  };

  // form elements
  final _formKey = GlobalKey<FormState>();

  // animation variables
  double animateWidth = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _intervalBedTime = formatIntervalTime(
      init: _startTime,
      end: _endTime,
      clockTimeFormat: _clockTimeFormat,
      clockIncrementTimeFormat: _clockIncrementTimeFormat,
    );

    resetWeekList();
  }

  void updateState() {
    setState(() {});
  }

  void createSendString() {
    // this block will create the data to send to API
    String priceDayString = '';

    timeList.forEach((key, value) {
      // ignore: prefer_is_empty
      if (value['timeAddList']?.length == 0) {
        priceDayString += key == 0 ? "" : ":";
        return;
      }

      var dayString = '';
      for (int i = 0; i < value['timeAddList']!.length; i++) {
        var elementValue = value['timeAddList']![i];
        String valueToAdd =
            "${elementValue['startTime']}_${elementValue['endTime']}_${elementValue['price']}_${elementValue['title']}";
        dayString +=
            i == value['timeAddList']!.length - 1 ? valueToAdd : "$valueToAdd;";
      }
      priceDayString += key == 0 ? dayString : ":$dayString";
    });
  }

  resetAllVariables() {
    resetWeekList();
    timeList = {
      0: {"startArr": [], "endArr": [], 'timeAddList': []},
      1: {"startArr": [], "endArr": [], 'timeAddList': []},
      2: {"startArr": [], "endArr": [], 'timeAddList': []},
      3: {"startArr": [], "endArr": [], 'timeAddList': []},
      4: {"startArr": [], "endArr": [], 'timeAddList': []},
      5: {"startArr": [], "endArr": [], 'timeAddList': []},
      6: {"startArr": [], "endArr": [], 'timeAddList': []},
    };
    peakList = [];
    showForm = false;
    isAdded = false;
    setState(() {});
  }

  // this functions reset the week list once the time has been addded or canceled.
  void resetWeekList() {
    _selectedIndexs = [
      {"values": false, "text": "Sunday", "id": 0},
      {"values": false, "text": "Monday", "id": 1},
      {"values": false, "text": "Tuesday", "id": 2},
      {"values": false, "text": "Wednesday", "id": 3},
      {"values": false, "text": "Thursday", "id": 4},
      {"values": false, "text": "Friday", "id": 5},
      {"values": false, "text": "Saturday", "id": 6}
    ];
  }

  void removeElement(element) {
    for (int i = 0; i < element['selectedDays'].length; i++) {
      var id = element['selectedDays'][i];
      timeList[id]!['startArr']?.remove(element['startFractionTime']);
      timeList[id]!['endArr']?.remove(element['endFractionTime']);
      timeList[id]!['timeAddList']?.removeWhere((timeElement) =>
          timeElement['startTime'] == element['startFractionTime']);
      if (element['endFractionTime'] < element['startFractionTime']) {
        timeList[id]!['startArr']?.remove(0);
        timeList[id]!['endArr']?.remove(2359);
        timeList[id]!['timeAddList']
            ?.removeWhere((timeElement) => timeElement['startTime'] == 0);
      }
    }
  }

  void deleteElement(index) {
    var element = peakList[index];
    removeElement(element);

    peakList.removeAt(index);
    peakList.isEmpty ? resetAllVariables() : setState(() {});
  }

  List calculateTimeGap() {
    bool isShowGap = false;
    Map<String, dynamic> timesToAdd = {};
    // we are checking if there is any gap between times
    timeList.forEach((key, value) {
      var missingTimeObj = {};
      if (value['startArr']?.length == 0 && !isShowGap) {
        isShowGap = true;
        timesToAdd = {
          "startTime": "00:00",
          "endTime": "23:59",
          "dayKey": key,
          "dayName": daysMap.keys
              .firstWhere((k) => daysMap[k] == key, orElse: () => "")
        };
        return;
      }
      for (int i = 0; i < value['startArr']!.length; i++) {
        var index = (i == value['startArr']!.length - 1) ? 0 : i + 1;
        var startRounded = (value['startArr']![index] / 100).ceil();
        var endRounded = (value['endArr']![i] / 100).ceil();
        var startPadded = value['startArr']![index].toString().padLeft(4, "0");
        var endPadded = value['endArr']![i].toString().padLeft(4, "0");
        if (!isShowGap) {
          if (index != 0) {
            if ((value['startArr']![index] - value['endArr']![i]) > 1 &&
                (startRounded - endRounded) == 0) {
              isShowGap = true;
              timesToAdd = {
                "startTime":
                    "${endPadded.substring(0, 2)}:${endPadded.substring(2, 4)}",
                "endTime":
                    "${startPadded.substring(0, 2)}:${startPadded.substring(2, 4)}",
                "dayKey": key,
                "dayName": daysMap.keys
                    .firstWhere((k) => daysMap[k] == key, orElse: () => "")
              };
              // timesToAdd[key]?.add(missingTimeObj);
            }
            // when the hour is next
            if ((startRounded - endRounded) > 0 &&
                (value['startArr']![index] - value['endArr']![i]) > 41) {
              isShowGap = true;
              timesToAdd = {
                "startTime":
                    "${endPadded.substring(0, 2)}:${endPadded.substring(2, 4)}",
                "endTime":
                    "${startPadded.substring(0, 2)}:${startPadded.substring(2, 4)}",
                "dayKey": key,
                "dayName": daysMap.keys
                    .firstWhere((k) => daysMap[k] == key, orElse: () => "")
              };
              // timesToAdd[key]?.add(missingTimeObj);
            }
          } else if (index == 0 &&
              (value['startArr']![index] - value['endArr']![i]) > -2359) {
            isShowGap = true;
            timesToAdd = {
              "startTime":
                  "${endPadded.substring(0, 2)}:${endPadded.substring(2, 4)}",
              "endTime":
                  "${startPadded.substring(0, 2)}:${startPadded.substring(2, 4)}",
              "dayKey": key,
              "dayName": daysMap.keys
                  .firstWhere((k) => daysMap[k] == key, orElse: () => "")
            };
            // timesToAdd[key]?.add(missingTimeObj);
          }
        }
      }
    });
    return [isShowGap, timesToAdd];
  }

  Widget weekCheckboxes(elem) {
    return StatefulBuilder(builder: ((context, setState) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
                activeColor: Colors.blue.shade800,
                value: elem['values'],
                onChanged: (value) => {
                      setState(
                        () => {elem['values'] = value},
                      )
                    }),
            Container(
              child: Text(
                elem['text'],
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }));
  }

  // this widget creates form for the different time phases
  /* Widget createForm(context, showForm) {
    return;
  }
 */

// when endTime is less than starttime but greater than 24(means 0 to 24 next day) then add elements.

  // these function will do all the calculation of conflict and make list and data
  Map? calculateData() {
    var dataString = '';
    var showError = false;
    Map returnMap = {};
    List selectedDaysIndexes = [];
    Map<dynamic, Map<String, List>> funTimeList = {...timeList};
    // add next two lines to utils
    int hourStart = int.parse(getStringFromHourAndMinutes(_startTime, ""));
    int hourEnd = int.parse(getStringFromHourAndMinutes(_endTime, ""));
    _selectedIndexs?.forEach((element) {
      if (showError) {
        return;
      }
      bool isOverlapping = false;
      if (element['values']) {
        List<dynamic>? dayList = funTimeList[element['id']]!['timeAddList'];
        if (dayList != null && dayList.isNotEmpty) {
          var startArrList = funTimeList[element['id']]!['startArr']!;
          var endArrList = funTimeList[element['id']]!['endArr']!;

          for (var i = 0; i < startArrList.length; i++) {
            if ((hourStart >= startArrList[i] && hourStart <= endArrList[i]) ||
                (hourEnd >= startArrList[i] && hourEnd <= endArrList[i])) {
              isOverlapping = true;
              showError = true;
              break;
            }
          }
        }
        if (!isOverlapping) {
          selectedDaysIndexes.add(element['id']);
          funTimeList[element['id']]!['startArr']?.add(hourStart);
          funTimeList[element['id']]!['endArr']?.add(hourEnd);
          if (hourEnd < hourStart) {
            funTimeList[element['id']]!['startArr']?.add(0000);
            funTimeList[element['id']]!['endArr']?.add(2359);
            funTimeList[element['id']]!['timeAddList']?.add({
              "title": nameController.text,
              "startTime": hourStart,
              "endTime": 2359,
              "price": double.parse(priceController.text)
            });
            funTimeList[element['id']]!['timeAddList']?.add({
              "title": nameController.text,
              "startTime": 0000,
              "endTime": hourEnd,
              "price": double.parse(priceController.text)
            });
          } else {
            funTimeList[element['id']]!['timeAddList']?.add({
              "title": nameController.text,
              "startTime": hourStart,
              "endTime": hourEnd,
              "price": double.parse(priceController.text)
            });
          }
          funTimeList[element['id']]!['timeAddList']!
              .sort((a, b) => a['startTime'].compareTo(b['startTime']));
        }
      }
      funTimeList[element['id']]!['startArr']?.sort(((a, b) => a.compareTo(b)));
      funTimeList[element['id']]!['endArr']?.sort(((a, b) => a.compareTo(b)));
    });

    returnMap = {
      "timeList": funTimeList,
      "selectedDaysIndexes": selectedDaysIndexes
    };
    return showError ? null : returnMap;
  }

  /* ################## ALL THE DIALOGUES START ########################*/

// this opens the dialog for
  Future nextDialog(context) {
    bool isError = false;
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: ((context, setState) {
          return AlertDialog(
            scrollable: true,
            insetPadding: EdgeInsets.zero,
            title: titleWidget(
                "Set your Prices!", "Enter price for every time phase."),
            content: Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                children: [
                  //if (showForm)
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          carInfoBoxes("Name", nameController),
                          TimePicker(
                            initTime: _startTime,
                            endTime: _endTime,
                            height: 260.0,
                            width: 260.0,
                            primarySectors: _clockTimeFormat.value ~/ 2,
                            secondarySectors: _clockTimeFormat.value ~/ 2,
                            decoration: timePickerStyle(),
                            onSelectionChange: (startTime, endTime,
                                [isDisable]) {
                              setState(() => {
                                    _startTime = startTime,
                                    _endTime = endTime,
                                    _intervalBedTime = formatIntervalTime(
                                      init: _startTime,
                                      end: _endTime,
                                      clockTimeFormat: _clockTimeFormat,
                                      clockIncrementTimeFormat:
                                          _clockIncrementTimeFormat,
                                    ),
                                  });
                            },
                            onSelectionEnd: (startTime, endTime, [isDisable]) {
                              _endTime = endTime.h == 24
                                  ? PickedTime(h: 23, m: 59)
                                  : endTime;
                              _startTime = startTime.h == 24
                                  ? PickedTime(h: 0, m: 0)
                                  : startTime;
                              setState(() => {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(62.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    child: TextFormField(
                                      controller: priceController,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          hintText: "Add Price (in cents)",
                                          hintStyle: TextStyle(fontSize: 10)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text.';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              timeWidget(
                                'From',
                                _startTime,
                                /* Icon(
                                Icons.power_settings_new_outlined,
                                size: 25.0,
                                color: Color(0xFF3CDAF7),
                              ), */
                              ),
                              timeWidget(
                                'To',
                                _endTime,
                                /* Icon(
                                Icons.notifications_active_outlined,
                                size: 25.0,
                                color: Color(0xFF3CDAF7),
                              ), */
                              ),
                            ],
                          ),
                          if (isError) showError()
                          /* Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: const Text("Add")),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    showForm = false;
                                  });
                                },
                                child: const Text("Cancel"))
                          ],
                        ) */
                        ],
                      )),
                  /* if (!showForm)
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          showForm = true;
                        });
                      },
                      child: Icon(Icons.add),
                    ) */
                ],
              ),
            ),
            actions: [
              //if (!showForm)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      openDialog(context);
                    },
                    child: Text("Back"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var returnList = calculateData();
                        if (returnList != null) {
                          timeList = returnList['timeList'];
                          Navigator.of(context).pop();
                          isError = false;
                          isAdded = true;
                          peakList.add({
                            "peakName": nameController.text,
                            "selectedDays": returnList['selectedDaysIndexes'],
                            "startTime":
                                getStringFromHourAndMinutes(_startTime, ":"),
                            "endTime":
                                getStringFromHourAndMinutes(_endTime, ":"),
                            "startFractionTime": double.parse(
                                getStringFromHourAndMinutes(_startTime, "")),
                            "endFractionTime": double.parse(
                                getStringFromHourAndMinutes(_endTime, "")),
                            "price": priceController.text,
                            "id": (_startTime.h + _endTime.h).toString() +
                                (returnList['selectedDaysIndexes'].length *
                                        DateTime.now().hour *
                                        DateTime.now().day)
                                    .toString(),
                          });
                          updateState();
                        } else {
                          setState(() => {isError = true});
                        }
                      }
                    },
                    child: Text("Submit"),
                  )
                ],
              )
            ],
          );
        }));
      },
    );
  }

  // this opens the dialog for
  Future openDialog(context) {
    return showDialog(
      context: context,
      builder: (context) {
        List weekList = _selectedIndexs!;
        return AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.zero,
          title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Select days"),
                const Text(
                  "Select for what days you want to set your times.",
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ]),
          content: Container(
            width: MediaQuery.of(context).size.width - 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [for (var elem in weekList) weekCheckboxes(elem)],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    resetWeekList();
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    _selectedIndexs = weekList;
                    Navigator.of(context).pop();
                    nextDialog(context);
                  },
                  child: Text("Next"),
                )
              ],
            )
          ],
        );
      },
    );
  }

  Future gapShowDialog(context, gapMap) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Set Price!!"),
                  Text(
                    "You have not yet set prices for this day and time.",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ]),
            content: Container(
              height: 300.0, // Change as per your requirement
              width: 300.0, // Change as per your requirement
              child: Text(
                  "${"Please add time for " + gapMap['dayName'] + " between " + gapMap['startTime'] + " and " + gapMap['endTime']}."),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"),
                  ),
                ],
              )
            ],
          );
        });
  }

  // on edit this function removes the already present values in 'timeList' so that we can upgrade those items.

  // this dialog opens up when you click on the container and it is used for editing the information.
  Future nextEditDialog(context, timeCard) {
    bool isError = false;
    nameController = TextEditingController(text: timeCard['peakName']);
    priceController = TextEditingController(text: timeCard['price']);
    var startTimeArr = timeCard['startTime'].split(":");
    _startTime = PickedTime(
        h: int.parse(startTimeArr[0]), m: int.parse(startTimeArr[1]));

    var endTimeArr = timeCard['endTime'].split(":");
    _endTime =
        PickedTime(h: int.parse(endTimeArr[0]), m: int.parse(endTimeArr[1]));

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: ((context, setState) {
          return AlertDialog(
            scrollable: true,
            insetPadding: EdgeInsets.zero,
            title: titleWidget(
                "Set your Prices!", "Enter price for every time phase."),
            content: Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                children: [
                  //if (showForm)
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          carInfoBoxes("Name", nameController),
                          TimePicker(
                            initTime: _startTime,
                            endTime: _endTime,
                            height: 260.0,
                            width: 260.0,
                            primarySectors: _clockTimeFormat.value ~/ 2,
                            secondarySectors: _clockTimeFormat.value ~/ 2,
                            decoration: timePickerStyle(),
                            onSelectionChange: (startTime, endTime,
                                [isDisable]) {
                              setState(() => {
                                    _startTime = startTime,
                                    _endTime = endTime,
                                    _intervalBedTime = formatIntervalTime(
                                      init: _startTime,
                                      end: _endTime,
                                      clockTimeFormat: _clockTimeFormat,
                                      clockIncrementTimeFormat:
                                          _clockIncrementTimeFormat,
                                    ),
                                  });
                            },
                            onSelectionEnd: (startTime, endTime, [isDisable]) {
                              setState(() => {
                                    _startTime = startTime,
                                    _endTime = endTime,
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(62.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    child: TextFormField(
                                      initialValue: timeCard['price'],
                                      //controller: priceController,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          hintText: "Add Price (in cents)",
                                          hintStyle: TextStyle(fontSize: 10)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text.';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              timeWidget(
                                'From',
                                _startTime,
                                /* Icon(
                                Icons.power_settings_new_outlined,
                                size: 25.0,
                                color: Color(0xFF3CDAF7),
                              ), */
                              ),
                              timeWidget(
                                'To',
                                _endTime,
                                /* Icon(
                                Icons.notifications_active_outlined,
                                size: 25.0,
                                color: Color(0xFF3CDAF7),
                              ), */
                              ),
                            ],
                          ),
                          if (isError) showError()
                          /* Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: const Text("Add")),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    showForm = false;
                                  });
                                },
                                child: const Text("Cancel"))
                          ],
                        ) */
                        ],
                      )),
                  /* if (!showForm)
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          showForm = true;
                        });
                      },
                      child: Icon(Icons.add),
                    ) */
                ],
              ),
            ),
            actions: [
              //if (!showForm)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      editDialog(context, timeCard, false);
                    },
                    child: Text("Back"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        removeElement(timeCard);
                        var returnList = calculateData();
                        if (returnList != null) {
                          timeList = returnList['timeList'];
                          Navigator.of(context).pop();
                          isError = false;
                          isAdded = true;
                          var updatedObj = {
                            "peakName": nameController.text,
                            "selectedDays": returnList['selectedDaysIndexes'],
                            "startTime":
                                getStringFromHourAndMinutes(_startTime, ":"),
                            "endTime":
                                getStringFromHourAndMinutes(_endTime, ":"),
                            "startFractionTime": double.parse(
                                getStringFromHourAndMinutes(_startTime, "")),
                            "endFractionTime": double.parse(
                                getStringFromHourAndMinutes(_endTime, "")),
                            "price": priceController.text,
                            "id": timeCard['id'],
                          };

                          peakList[peakList.indexWhere((element) =>
                              element['id'] == timeCard['id'])] = updatedObj;

                          updateState();
                        } else {
                          setState(() => {isError = true});
                        }
                      }
                    },
                    child: Text("Submit"),
                  )
                ],
              )
            ],
          );
        }));
      },
    );
  }

  // This is edit dialog lot of the code is common with new dialog so try to take out common part as much as possible
  Future editDialog(context, selectedCard, [isUpdate]) {
    _selectedIndexs?.forEach((element) {
      if (selectedCard['selectedDays'].contains(element['id']) && isUpdate) {
        element['values'] = true;
      } else if (isUpdate) {
        element['values'] = false;
      }
    });
    return showDialog(
      context: context,
      builder: (context) {
        List weekList = _selectedIndexs!;
        return AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.zero,
          title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Select days"),
                const Text(
                  "Select for what days you want to set your times.",
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ]),
          content: Container(
            width: MediaQuery.of(context).size.width - 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [for (var elem in weekList) weekCheckboxes(elem)],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    resetWeekList();
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    _selectedIndexs = weekList;
                    Navigator.of(context).pop();
                    nextEditDialog(context, selectedCard);
                  },
                  child: Text("Next"),
                )
              ],
            )
          ],
        );
      },
    );
  }
  /* ###################   END ##################### */

  /* Warning dialog start */
  Future showWarningDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Warning",
              style: TextStyle(color: Colors.red),
            ),
            content: Container(
                child: const Text(
                    "Are you sure you want to go back? All your data will be lost.")),
            actions: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Back"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"),
                  ),
                ],
              )
            ],
          );
        });
  }
  /* Warning dialog End */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            List gapList = calculateTimeGap();
            if (gapList[0] == true) {
              gapShowDialog(context, gapList[1]);
            } else {
              createSendString();
            }
          },
          child: const Text("Save"),
          color: Colors.blue,
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    InkWell(
                      hoverColor: Colors.blue,
                      focusColor: Colors.blue,
                      child: const Icon(
                        Icons.keyboard_arrow_left,
                        size: 32,
                      ),
                      onTap: () {
                        List gapList = calculateTimeGap();
                        if (gapList[0]) {
                          showWarningDialog(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    Text(
                      "Price Setup",
                      style: headerText,
                    ),
                    Flexible(
                        child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            resetAllVariables();
                          });
                        },
                        child: Text(
                          "Delete All",
                          style: TextStyle(color: Colors.blue.shade700),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              if (peakList.isNotEmpty)
                Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: peakList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 10.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          child: ListTile(
                              selectedTileColor: Colors.blue,
                              contentPadding: const EdgeInsets.only(left: 20.0),
                              leading: Container(
                                padding: const EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: const BorderSide(
                                            width: 1.0,
                                            color: Colors.white24))),
                                child: const Icon(Icons.timelapse,
                                    color: Colors.white),
                              ),
                              title: InkWell(
                                onTap: () {
                                  editDialog(context, peakList[index], true);
                                },
                                child: Text(
                                  peakList[index]['peakName'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                              trailing: InkWell(
                                onTap: () {
                                  deleteElement(index);
                                },
                                child: AnimatedContainer(
                                  height: 100,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20.0))),
                                  duration: Duration(milliseconds: 300),
                                  child: const Icon(Icons.delete,
                                      color: Colors.white, size: 30.0),
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                ),
              Align(
                child: FloatingActionButton(
                  focusColor: Colors.blue.shade800,
                  backgroundColor: Colors.blue.shade800,
                  splashColor: Colors.blue.shade400,
                  onPressed: () {
                    openDialog(context);
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
