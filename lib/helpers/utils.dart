import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soneilcharging/helpers/constant.dart';
import 'package:intl/intl.dart' as intl;

Future<void> setLoginStatus(value) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  prefs.setBool("isLoggedIn", value);
}

// checks the validity of the email
bool isValidEmail(value) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value);
}

// this class build custom pain widget to draw curves

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blue.shade800;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.3,
        size.width * 0.6, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.4,
        size.width * 1.0, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// line pain
class linePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blue.shade800;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 1);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// forgot password curve
class forgotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blue.shade800;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0);
    path.quadraticBezierTo(
        size.width, size.height * (0.1), size.width * 1.6, size.height * (0.9));
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// reset  curve
class resetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blue.shade800;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * (-1.3), size.height * (0.3), size.width,
        size.height * 0.9);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// this creates the curve
/* class Arc extends CustomPainter {

  double _degreeToRadians(num degree) {
    return (degree * math.pi) / 180.0;
  }
  
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTRB(0, 0, size.width, size.height * 2);
    double startAngle = _degreeToRadians(0);
    double sweepAngle = _degreeToRadians(180);
    const useCenter = false;
    Paint paint = Paint();
    paint.color = Colors.yellow;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
} */

// vertical line
class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.white38
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// this funtion redirects the page with animation
Route createRoute(page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (c, anim, a2, child) =>
        FadeTransition(opacity: anim, child: child),
    transitionDuration: Duration(milliseconds: 500),
  );
}

// this function brings the new page from the right side.
Route createRouteAnim(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route createRouteAnimDown(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

//////////// HELPFUL FUNTIONS /////////////
String getTimeStringFromDouble(hourValue, minuteValue, value) {
  if (value < 0) return 'Invalid Value';
  return '$hourValue hour $minuteValue minutes';
}

// calculates minutes in a string
String getMinuteString(double value) {
  int flooredValue = value.floor();
  double decimalValue = value - flooredValue;
  return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
}

// calculates minutes to fraction
double convertMinutetoFraction(int minuteValue) {
  return (minuteValue / 60).toDouble();
}

// calculates hour in a string
String getHourString(double value) {
  int flooredValue = value.floor();
  double decimalValue = value - flooredValue;
  return '${flooredValue % 24}'.padLeft(2, '0');
}

Widget showTime(time) {
  return Text(time);
}

String getStringFromHourAndMinutes(time, [isSign]) {
  if (isSign != null) {
    return '${intl.NumberFormat('00').format(time.hour)}$isSign${intl.NumberFormat('00').format(time.minute)}';
  }
  return '${intl.NumberFormat('00').format(time.hour)}:${intl.NumberFormat('00').format(time.minute)}';
}

int getMinuteFromString(int hour, int minutes) {
  var hourInMinutes = (hour * 60);
  return hourInMinutes + minutes;
}

String getHourFormatString(String hourMinute, [String symbol = ":"]) {
  hourMinute = hourMinute.padLeft(4, '0');
  return "${hourMinute.substring(0, 2)}$symbol${hourMinute.substring(2, 4)}";
}

//////// END  ///////////////////

/// This block gets path to the application and stores the data in the txt file, performs CRUD operations /////

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> _localFile(fileName) async {
  final path = await _localPath;
  return File('$path/$fileName');
}

/*Future<File> get _localFile async {
  final path = await _localPath;
  print(path);
  return File('$path/chargeHistory.txt');
}*/

/* 
Files we have
  chargingStatus.txt
  addedVehicles.txt
  scheduleCharging.txt
*/

Future<void> writeCounter(fileName, jsonStr) async {
  final file = await _localFile(fileName);

  // Write the file
  await file.writeAsString(jsonStr);
}

Future<String> readCounter(fileName) async {
  try {
    final file = await _localFile(fileName);

    // Read the file
    final contents = await file.readAsString();

    return contents as String;
  } catch (e) {
    // If encountering an error, return 0
    return "";
  }
}

/// END /////

//// SnackBar Start /////
showSnackBar(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: smallTexts,
    ),
    backgroundColor: Colors.blue,
    dismissDirection: DismissDirection.down,
    elevation: 10,
  ));
}

/// END  ////