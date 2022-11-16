import 'package:flutter/material.dart';

import '../../helpers/constant.dart';
import '../../helpers/utils.dart';
import '../../serivces/globalVars.dart';

class chargePathWidget extends StatefulWidget {
  const chargePathWidget({Key? key}) : super(key: key);

  @override
  State<chargePathWidget> createState() => _chargePathWidgetState();
}

class _chargePathWidgetState extends State<chargePathWidget> {
  globalVars _myService = globalVars();

  // this data needs to be fetched on this page as well.
  Map<String, dynamic> carStatus = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    carStatus = _myService.createJson();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(text: "Charging Plan", style: headTexts),
                    ]))
                  ],
                ),
                showCarPlanWidget(carStatus: carStatus)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class showCarPlanWidget extends StatefulWidget {
  final Map<String, dynamic> carStatus;
  const showCarPlanWidget({Key? key, required this.carStatus})
      : super(key: key);

  @override
  State<showCarPlanWidget> createState() => _showCarPlanWidgetState();
}

class _showCarPlanWidgetState extends State<showCarPlanWidget> {
  String estimatedTime = '';
  String chargingStartTime = '';
  String chargingEndTime = '';
  String chargingEndEstimation = '';
  double power = 0.0;
  bool isCrossingEcoCheck = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    calculateChargingSummary();
  }

  // this general funtion calculates estimated time given different inputs.
  dynamic calculateTimeToCharge(current, voltage, totalCapacity) {
    var power = (current * voltage) / 1000;
    var timeToCharge = totalCapacity / power;
    return timeToCharge;
  }

  void extractEstimatedTime(timeFraction, hourStartValue, minuteStartValue) {
    // getting the value in hour and minutes.
    String hourTotalValue = getHourString(timeFraction);
    String minuteTotalValue = getMinuteString(timeFraction);
    estimatedTime =
        getTimeStringFromDouble(hourTotalValue, minuteTotalValue, timeFraction);

    // calculating hour and minute from time string
    var hourEndValue = hourStartValue + int.parse(hourTotalValue);
    var minuteEndValue = minuteStartValue + int.parse(minuteTotalValue);

    String hourEndString = '';
    String minuteEndString = '';
    if (hourEndValue >= 24) {
      hourEndValue -= 24;
    }
    if (minuteEndValue >= 60) {
      minuteEndValue -= 60;
    }
    hourEndString = hourEndValue.toString();
    minuteEndString = minuteEndValue.toString();
    chargingEndTime = hourEndString + ":" + minuteEndString;
    chargingEndEstimation =
        getTimeStringFromDouble(hourEndString, minuteEndString, hourEndValue);
  }

  // this function checks if we are in the time where charging prices are low
  void checkEcoCharging(hourStartTime, minuteStartTime, totalTimeFraction) {
    // getting the value in hour and minutes.
    var hourEndTime = int.parse(getHourString(totalTimeFraction));
    var minuteEndTime = int.parse(getMinuteString(totalTimeFraction));

    var isEcoCharging = widget.carStatus['isEcoCharging'];
    var minuteStartValue = convertMinutetoFraction(minuteStartTime);
    var minuteEndValue = convertMinutetoFraction(minuteEndTime);

    var startTime = hourStartTime + minuteStartValue;
    var endTime = hourEndTime + minuteEndValue;

    if (isEcoCharging) {
      if (hourStartTime >= 19 || hourStartTime <= 7) {
        // if we started charging in eco-charge time.
      } else {
        // check if time crosses the mark of 7PM
        var timetoEco = startTime - 19;
        var addTotalTime = timetoEco + hourEndTime;
        if (addTotalTime > 0) {
          isCrossingEcoCheck = true;
          var totalCharged = timetoEco * -1 * power;
          var remainingCharging = (widget.carStatus['batteryCapacity'] *
                  widget.carStatus['targetBatteryLevel'] /
                  100) -
              totalCharged;

          var timeToPowerCharging =
              calculateTimeToCharge(32, 240, remainingCharging);

          var timeFraction = timetoEco * -1 + timeToPowerCharging;
          extractEstimatedTime(timeFraction, hourStartTime, minuteStartTime);
          // next calculate charging end time
        } else {}
      }

      // first we will check if our charging will go into the eco-charging time

    }
  }

  void calculateChargingSummary() {
    // power from current and voltage
    power =
        widget.carStatus['currentLevel'] * widget.carStatus['voltLevel'] / 1000;

    // calculating total capacity in reference to target level.
    var capacityPerLevel = widget.carStatus['batteryCapacity'] *
        widget.carStatus['targetBatteryLevel'] /
        100;

    // calculating total capacity in reference to target level.
    chargingStartTime = widget.carStatus['chargingStartTime'];
    var hourString = chargingStartTime.split(":")[0];
    var minuteString = chargingStartTime.split(":")[1];

    //  calculating total charging time in fraction.
    var timeFraction = calculateTimeToCharge(widget.carStatus['currentLevel'],
        widget.carStatus['voltLevel'], capacityPerLevel);

    extractEstimatedTime(
        timeFraction, int.parse(hourString), int.parse(minuteString));

    checkEcoCharging(
        int.parse(hourString), int.parse(minuteString), timeFraction);
  }

  Widget showSummary() {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: Column(
        children: [
          const Text("Estimated Total Time"),
          Text(
            estimatedTime,
            style: headerText,
          ),
          SizedBox(
            height: 20,
          ),
          const Text("Charging ends at"),
          Text(
            chargingEndEstimation,
            style: headerText,
          ),
        ],
      ),
    );
  }

  Widget showEcoChargingMessage() {
    if (widget.carStatus['isEcoCharging'] == true) {
      return Text(
          "Eco-charging is enabled that means between 7 PM TO 7 AM, charging will go to maximum.");
    } else {
      return Text(
          "Eco-charging is disabled. Charging will happen on set current and voltage. Enable eco-charging to charge your car faster.");
    }
  }

  Widget showPlanRow(title, desc, time, [isLast = false]) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.ev_station_rounded),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 280,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title),
                      Text(
                        desc,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
            showTime(time),
          ],
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CustomPaint(
                size: Size(double.infinity, 80),
                painter: DashedLineVerticalPainter()),
          ),
      ],
    );
  }

  Widget showPlan() {
    return Column(
      children: [
        showPlanRow("Charging started",
            "You plugged the car for charging at 20%.", chargingStartTime),
        showPlanRow(
            "Charging done 50%!!",
            "Charging with current: ${widget.carStatus['currentLevel']}A and Voltage: ${widget.carStatus['voltLevel']}V",
            "13:47"),
        if (isCrossingEcoCheck)
          showPlanRow("Updated Configurations",
              "Charging with current: 32A and Voltage: 240V", "19:00"),
        showPlanRow(
            "Charging Done",
            "This assumption is for " +
                widget.carStatus['targetBatteryLevel'].toString() +
                "% charging. Change target level to see changes here.",
            chargingEndTime,
            true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.carStatus['currentBatteryLevel'] < 100) {
      return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            const Text(
              "You can see here the plan of your charging and How much time it will take to fully charge your car.",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 24,
            ),
            showPlan(),
            SizedBox(
              height: 24,
            ),
            showEcoChargingMessage(),
            showSummary()
          ],
        ),
      );
    } else {
      return const Text("Your car is fully charged!! Go and Drive :).");
    }
  }
}
