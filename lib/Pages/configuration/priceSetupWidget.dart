import 'package:flutter/material.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';
import 'package:intl/intl.dart' as intl;
import '../../helpers/constant.dart';
import '../../helpers/inputStyleWidget.dart';

class PriceSetupWidget extends StatefulWidget {
  const PriceSetupWidget({Key? key}) : super(key: key);

  @override
  State<PriceSetupWidget> createState() => _PriceSetupWidgetState();
}

class _PriceSetupWidgetState extends State<PriceSetupWidget> {
  List? _selectedIndexs;

  ClockTimeFormat _clockTimeFormat = ClockTimeFormat.TWENTYFOURHOURS;
  ClockIncrementTimeFormat _clockIncrementTimeFormat =
      ClockIncrementTimeFormat.ONEMIN;

  bool showForm = false;

  TextEditingController nameController = TextEditingController(text: "Peak");
  TextEditingController priceController = TextEditingController();

  PickedTime _startTime = PickedTime(h: 0, m: 0);
  PickedTime _endTime = PickedTime(h: 8, m: 0);

  PickedTime _intervalBedTime = PickedTime(h: 0, m: 0);

  PickedTime _disabledInitTime = PickedTime(h: 12, m: 0);
  PickedTime _disabledEndTime = PickedTime(h: 20, m: 0);

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
  void calculateData() {
    var dataString = '';
    // add next two lines to utils
    int hourStart = int.parse(
        '${intl.NumberFormat('00').format(_startTime.h)}${intl.NumberFormat('00').format(_startTime.m)}');
    int hourEnd = int.parse(
        '${intl.NumberFormat('00').format(_endTime.h)}${intl.NumberFormat('00').format(_endTime.m)}');
    _selectedIndexs?.forEach((element) {
      if (element['values']) {
        List<dynamic>? dayList = timeList[element['id']]![['timeAddList']];
        if (dayList!.isEmpty) {
          timeList[element['id']]!['startArr']?.add(hourStart);
          timeList[element['id']]!['endArr']?.add(hourEnd);
          timeList[element['id']]!['timeAddList']?.add({
            "title": nameController.text,
            "startTime": hourStart,
            "endTime": hourEnd,
            "price": double.parse(priceController.text)
          });
        } else {
          var startArrList = timeList[element['id']]!['startArr']
              ?.sort(((a, b) => a.compareTo(b)));
          var endArrList = timeList[element['id']]!['endArr']
              ?.sort(((a, b) => a.compareTo(b)));
        }
      }
    });
  }

  Widget _timeWidget(String title, PickedTime time, [Icon? icon]) {
    return Container(
      width: 100.0,
      decoration: BoxDecoration(
        color: Color(0xFF1F2633),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              '${intl.NumberFormat('00').format(time.h)}:${intl.NumberFormat('00').format(time.m)}',
              style: TextStyle(
                color: Color.fromARGB(255, 70, 170, 190),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '$title',
              style: TextStyle(
                color: Color(0xFF3CDAF7),
                fontSize: 16,
              ),
            ),
            // icon,
          ],
        ),
      ),
    );
  }

  // this opens the dialog for
  Future nextDialog(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: ((context, setState) {
          return AlertDialog(
            scrollable: true,
            insetPadding: EdgeInsets.zero,
            title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Set your Prices"),
                  const Text(
                    "Enter price for every time phase.",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ]),
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
                              _timeWidget(
                                'From',
                                _startTime,
                                /* Icon(
                                Icons.power_settings_new_outlined,
                                size: 25.0,
                                color: Color(0xFF3CDAF7),
                              ), */
                              ),
                              _timeWidget(
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
                        calculateData();
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
        ;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SingleChildScrollView(
            child: Column(
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
                  "Price Setup",
                  style: headerText,
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: FloatingActionButton(
                focusColor: Colors.blue.shade800,
                backgroundColor: Colors.blue.shade800,
                splashColor: Colors.blue.shade400,
                onPressed: () {
                  openDialog(context);
                },
                child: Icon(Icons.add),
              ),
            )
          ],
        )),
      ),
    );
  }
}
