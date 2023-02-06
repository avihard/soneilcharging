import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:progressive_time_picker/progressive_time_picker.dart';

ClockTimeFormat _clockTimeFormat = ClockTimeFormat.TWENTYFOURHOURS;
final ClockIncrementTimeFormat _clockIncrementTimeFormat =
    ClockIncrementTimeFormat.ONEMIN;

timePickerStyle() {
  return TimePickerDecoration(
    baseColor: Color(0xFF1F2633),
    sweepDecoration: TimePickerSweepDecoration(
      pickerStrokeWidth: 15.0,
      pickerColor: Color(0xFF3CDAF7),
      showConnector: true,
    ),
    initHandlerDecoration: TimePickerHandlerDecoration(
      color: Color(0xFF141925),
      shape: BoxShape.circle,
      radius: 12.0,
    ),
    endHandlerDecoration: TimePickerHandlerDecoration(
      color: Color(0xFF141925),
      shape: BoxShape.circle,
      radius: 12.0,
    ),
    clockNumberDecoration: TimePickerClockNumberDecoration(
      defaultTextColor: Colors.white,
      defaultFontSize: 12.0,
      scaleFactor: 1.0,
      showNumberIndicators: true,
      clockTimeFormat: _clockTimeFormat,
      clockIncrementTimeFormat: _clockIncrementTimeFormat,
    ),
  );
}

Widget timeWidget(String title, PickedTime time, [Icon? icon]) {
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
          /* Row(
            children: [
              TextFormField()
            ],
          ), */
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

Widget titleWidget(title, [subTitle = '']) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(
          subTitle,
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
      ]);
}

Widget showError() {
  return Column(
    children: [
      SizedBox(
        height: 10,
      ),
      const Text(
        "Time is Conflicting",
        style: TextStyle(color: Colors.red),
      )
    ],
  );
}
