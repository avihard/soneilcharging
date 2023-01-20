import 'package:flutter/material.dart';
import 'package:soneilcharging/Pages/scheduling/schedule.dart';
import 'package:soneilcharging/helpers/constant.dart';

import '../../enums/enums.dart';
import '../../helpers/utils.dart';

class calculateWidget extends StatefulWidget {
  const calculateWidget({Key? key}) : super(key: key);

  @override
  State<calculateWidget> createState() => _calculateWidgetState();
}

class _calculateWidgetState extends State<calculateWidget> {
  final _formKey = GlobalKey<FormState>();

  TimeOfDay _time = TimeOfDay(hour: 12, minute: 00);

  TextEditingController mileController = TextEditingController();
  TextEditingController voltageController = TextEditingController();
  TextEditingController currentController = TextEditingController();
  TextEditingController distanceController = TextEditingController(text: "100");

  // per hour miles covered by car
  double perHourMiles = 0;
  double distValue = 0;
  double distanceTimeFraction = 0;
  String distanceTime = "";
  bool isInfo = false;
  double power = 0;

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

  void calculateValues() {
    // getting all the values from the submitted form.
    double mileValue = double.parse(mileController.text);
    double currValue = double.parse(currentController.text);
    double voltValue = double.parse(voltageController.text);
    distValue = double.parse(distanceController.text);

    // calculating the power and energy from the voltage, current and 1 hr value.
    power = (voltValue * currValue) / 1000;
    double energy = (power * 1);

    perHourMiles = energy / mileValue;

    distanceTimeFraction = distValue / perHourMiles;

    String hourTotalValue = getHourString(distanceTimeFraction);
    String minuteTotalValue = getMinuteString(distanceTimeFraction);

    setState(() {
      distanceTime = "$hourTotalValue:$minuteTotalValue";
      isInfo = true;
    });
  }

  Widget createTextBox(unitText, controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 30,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (val) {
                print('saved');
              },
            ),
          ),
          Text(unitText)
        ],
      ),
    );
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        isInfo = false;
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
                      () => {elem['values'] = value, isInfo = false},
                    )
                  })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      "Calculator",
                      style: headerText,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Use thie calculator to input battery capacity and charging settings to estimate the amount of time and amount it takes to charge.",
                  style: TextStyle(color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: _selectTime,
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Select Time"),
                                Text("${_time.hour}:${_time.minute}")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const Text("Electricity Per Mile"),
                        createTextBox("kwh/mi", mileController),
                        const Text("Current"),
                        createTextBox("A", currentController),
                        const Text("Voltage"),
                        createTextBox("V", voltageController),
                        const Text("Distance you want to travel (in Miles)"),
                        createTextBox("mi", distanceController),
                        const Text("Select Days"),
                        SizedBox(
                          height: 15,
                        ),
                        Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              for (var elem in _selectedIndexs)
                                weekCheckboxes(elem)
                            ]),
                        ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              showSnackBar(context, 'Processing Data');
                              calculateValues();
                            }
                          },
                          child: const Text('Calculate'),
                        ),
                        if (isInfo)
                          calcInfoWidget(
                              perHourMiles: perHourMiles,
                              distanceTime: distanceTime,
                              distValue: distValue,
                              distanceTimeFraction: distanceTimeFraction,
                              time: _time,
                              selectedDays: _selectedIndexs,
                              power: power),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class calcInfoWidget extends StatelessWidget {
  final perHourMiles, distanceTime, distValue, distanceTimeFraction;

  TimeOfDay time;

  List<Map<String, dynamic>> calcList = [];
  List<Map<String, dynamic>> weekendList = [];

  List selectedDays;

  bool isWeekdays = false;
  bool isWeekend = false;

  double weekDayPrice = 0;
  double weekendPrice = 0;
  double power = 0;

  calcInfoWidget(
      {Key? key,
      required this.perHourMiles,
      required this.distanceTime,
      required this.distValue,
      required this.distanceTimeFraction,
      required this.time,
      required this.selectedDays,
      required this.power})
      : super(key: key);

  void checkDaysList() {
    var weekendList = selectedDays.where((i) {
      if (i['values'] && (i['text'] == 'Sun' || i['text'] == 'Sat')) {
        isWeekend = true;
        return true;
      }
      return false;
    }).toList();
    var weekDayList = selectedDays.where((i) {
      if (i['values'] && (i['text'] != 'Sun' && i['text'] != 'Sat')) {
        isWeekdays = true;
        return true;
      }
      return false;
    }).toList();
  }

  double calWeekendTable(startTime, endTime, totalChargingHrs) {
    double price = 0;
    var totalTime = totalChargingHrs;

    Map<String, dynamic> chargeSession = {};

    if (endTime >= 24.0) {
      endTime -= 24.0;
    }

    double tempPrice =
        power * totalChargingHrs * electricityPrice['offPeak']!['price'];

    String timeSession =
        "${getHourString(totalChargingHrs)}:${getMinuteString(totalChargingHrs)}";

    String startSession =
        "${getHourString(startTime)}:${getMinuteString(startTime)}";

    String endSession = "${getHourString(endTime)}:${getMinuteString(endTime)}";

    chargeSession = {
      "Price": tempPrice.toStringAsFixed(2),
      "PeakName": electricityPrice['offPeak']!["id"],
      "ChargingHrs": timeSession,
      "SessionStart": startSession,
      "SessionEnd": endSession
    };

    weekendList.add(chargeSession);

    return price;
  }

  double calcCostTable(startTime, endTime, totalChargingHrs) {
    double price = 0;
    var totalTime = totalChargingHrs;
    dynamic result;
    electricityPrice.entries.forEach((element) {
      if (electricityPrice[element.key]!['startTime'] <= startTime &&
          electricityPrice[element.key]!['endTime'] > startTime) {
        result = electricityPrice[element.key];
      }
    });

    if ((startTime >= 19 && startTime < 24) ||
        (startTime >= 0 && startTime < 7)) {
      result = electricityPrice["offPeak"];
    }

    Map<String, dynamic> chargeSession = {};

    while (totalTime > 0) {
      double timeForPeak = 0;
      double endTime = 0;
      double sessionStartTime = 0;
      startTime =
          (startTime > result['startTime']) || (startTime >= 0 && startTime < 7)
              ? startTime
              : result['startTime'];

      /* if (result['PeakName'] == 'Off Peak') {
        if (startTime >= 19 && startTime <= 24) {
          startTime = 24 - startTime + 7;
        }
      } */

      if ((startTime >= 19 && startTime < 24)) {
        if (totalTime > (result['endTime'] + (24 - startTime))) {
          timeForPeak = result['endTime'] + (24 - startTime);
          endTime = result['endTime'];
        } else {
          timeForPeak = totalTime;
          endTime = startTime + totalTime;
        }
      } /* else if (startTime >= 0 && startTime < 7) {
        if (totalTime >= (result['endTime'] - startTime)) {
          timeForPeak = (result['endTime'] - startTime);
          endTime = result['endTime'];
        } else {
          timeForPeak = totalTime;
          endTime = result['startTime'] + totalTime;
        }
      } */
      else {
        if (totalTime >= (result['endTime'] - startTime).abs()) {
          timeForPeak = (result['endTime'] - startTime);
          endTime = result['endTime'];
        } else {
          timeForPeak = totalTime;
          endTime = startTime + totalTime;
        }
      }

      var tempPrice = power * timeForPeak * result['price'];
      price += tempPrice;

      if (endTime >= 24.0) {
        endTime -= 24.0;
      }

      /* Getting all the time */
      String timeSession =
          getHourString(timeForPeak) + ":" + getMinuteString(timeForPeak);
      String startSession =
          getHourString(startTime) + ":" + getMinuteString(startTime);
      String endSession =
          getHourString(endTime) + ":" + getMinuteString(endTime);
      /* */
      chargeSession = {
        "Price": tempPrice.toStringAsFixed(2),
        "PeakName": result["id"],
        "ChargingHrs": timeSession,
        "SessionStart": startSession,
        "SessionEnd": endSession
      };
      totalTime -= timeForPeak;
      result = electricityPrice[result['nextPeak']];
      startTime = result['startTime'];
      calcList.add(chargeSession);
    }

    return price;
  }

  double calcPrice() {
    checkDaysList();
    double totalChargingHrs = 0.0;
    var currentTimeFraction =
        time.hour + convertMinutetoFraction(this.time.minute);

    var endTime = currentTimeFraction + distanceTimeFraction;
    if (endTime >= 24.0) {
      endTime = endTime - 24.0;
    }

    // count total charging hrs
    if (currentTimeFraction > endTime) {
      totalChargingHrs = (endTime - 0) + (24 - currentTimeFraction);
    } else {
      totalChargingHrs = endTime - currentTimeFraction;
    }

    // create view and list for weekdays
    if (isWeekdays) {
      weekDayPrice =
          calcCostTable(currentTimeFraction, endTime, totalChargingHrs);
    }

    // create view and list for weekend
    if (isWeekend) {
      weekendPrice =
          calWeekendTable(currentTimeFraction, endTime, totalChargingHrs);
    }
    return weekDayPrice;
  }

  @override
  Widget build(BuildContext context) {
    var price = calcPrice();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Number of Miles can be covered with 1 hr of charging"),
            Text(
              this.perHourMiles.toString() + " miles",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 20,
            ),
            Text("So, it will take approximate " +
                this.distanceTime +
                " hour of charging to go to " +
                distValue.toString() +
                " miles."),
            if (isWeekdays)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "Charging Time",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      /* SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: */
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          dividerThickness: 2.0,
                          columns: [
                            for (var key in peakColumns.keys)
                              DataColumn(
                                  label: Text(peakColumns[key].toString())),
                          ],
                          rows:
                              calcList // Loops through dataColumnText, each iteration assigning the value to element
                                  .map(
                                    ((element) => DataRow(
                                          cells: <DataCell>[
                                            //Extracting from Map element the value
                                            DataCell(Text(element["PeakName"]
                                                .toString())),
                                            DataCell(
                                                Text(element["ChargingHrs"])),
                                            DataCell(Text(element["Price"])),
                                            DataCell(
                                                Text(element["SessionStart"])),
                                            DataCell(
                                                Text(element["SessionEnd"]))
                                          ],
                                        )),
                                  )
                                  .toList(),
                          showBottomBorder: true,
                        ),
                      ),
                      DataTable(
                        headingRowHeight: 0,
                        columnSpacing: 80.0,
                        columns: [
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('')),
                        ],
                        rows: [
                          DataRow(
                            cells: [
                              DataCell(const Text("")),
                              DataCell(const Text("")),
                              DataCell(Text(
                                  "Total Price: " + price.toStringAsFixed(2))),
                            ],
                          ),
                        ],
                      )
                      //),
                    ],
                  ),
                ),
              ),
            if (isWeekend)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "Charging On Weekends",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          dividerThickness: 2.0,
                          columns: [
                            for (var key in peakColumns.keys)
                              DataColumn(
                                  label: Text(peakColumns[key].toString())),
                          ],
                          rows:
                              weekendList // Loops through dataColumnText, each iteration assigning the value to element
                                  .map(
                                    ((element) => DataRow(
                                          cells: <DataCell>[
                                            //Extracting from Map element the value
                                            DataCell(Text(element["PeakName"]
                                                .toString())),
                                            DataCell(
                                                Text(element["ChargingHrs"])),
                                            DataCell(Text(element["Price"])),
                                            DataCell(
                                                Text(element["SessionStart"])),
                                            DataCell(
                                                Text(element["SessionEnd"]))
                                          ],
                                        )),
                                  )
                                  .toList(),
                          showBottomBorder: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
