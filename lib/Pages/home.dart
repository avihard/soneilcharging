// ignore_for_file: unnecessary_new

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:battery/battery.dart';
import 'dart:async';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../helpers/constant.dart';
import 'history/currChargeHistory.dart';

const dynamic informationObject = [
  {"title": "Current", "value": 32, "unit": "Ampere", "icons": Icons.volcano},
  {"title": "Voltage", "value": 205, "unit": "Voltage", "icons": Icons.volcano},
  {
    "title": "Temperature",
    "value": 26,
    "unit": "Celsius",
    "icons": Icons.volcano
  },
  {"title": "Cycles", "value": 4, "unit": "", "icons": Icons.volcano}
];

class HomeWidget extends StatelessWidget {
  final VoidCallback onButtonPressed;
  const HomeWidget({Key? key, required this.onButtonPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          batteryWidget(),
          SizedBox(
            height: 40,
          ),
          informationWidget(onButtonPressed: onButtonPressed),
        ],
      ),
    );
  }
}

// this widget shows battery charging information
class batteryWidget extends StatefulWidget {
  const batteryWidget({Key? key}) : super(key: key);

  @override
  State<batteryWidget> createState() => _batteryWidgetState();
}

class _batteryWidgetState extends State<batteryWidget> {
  final battery = Battery();
  int batteryLevel = 100;
  BatteryState batteryState = BatteryState.full;

  late Timer timer;
  late StreamSubscription subscription;

  /* @override
  void initState() {
    super.initState();

    listenBatteryLevel();
    listenBatteryState();
  }

  void listenBatteryState() =>
      subscription = battery.onBatteryStateChanged.listen(
        (batteryState) => setState(() => this.batteryState = batteryState),
      );

  void listenBatteryLevel() {
    updateBatteryLevel();

    timer = Timer.periodic(
      Duration(seconds: 10),
      (_) async => updateBatteryLevel(),
    );
  }

  Future updateBatteryLevel() async {
    final batteryLevel = await battery.batteryLevel;

    setState(() => this.batteryLevel = batteryLevel);
  } */

  Widget buildBatteryLevel(int batteryLevel) => Text(
        '$batteryLevel%',
        style: TextStyle(
          fontSize: 46,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget buildBatteryState(BatteryState batteryState) {
    final style = TextStyle(fontSize: 32, color: Colors.white);
    final double size = 300;

    switch (batteryState) {
      case BatteryState.full:
        final color = Colors.green;

        return Column(
          children: [
            Stack(
              children: [
                Icon(Icons.battery_charging_full_sharp,
                    size: size, color: color),
              ],
            ),
            Text('Full!', style: style.copyWith(color: color)),
          ],
        );
      case BatteryState.charging:
        final color = Colors.green;

        return Column(
          children: [
            Icon(Icons.battery_charging_full, size: size, color: color),
            Text('Charging...', style: style.copyWith(color: color)),
          ],
        );
      case BatteryState.discharging:
      default:
        final color = Colors.red;
        return Column(
          children: [
            Icon(Icons.battery_alert, size: size, color: color),
            Text('Discharging...', style: style.copyWith(color: color)),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.grey,
                  Colors.black,
                ],
              )),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "EV Charger",
                      style: headerText,
                    ),
                    InkWell(
                      child: buildBatteryState(batteryState),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => currChargeHistoryWidget()),
                        )
                      },
                    ),
                    const SizedBox(height: 32),
                    buildBatteryLevel(batteryLevel),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: -45,
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.only(top: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                ),
                child: const Text(
                  "Last Updated on 11:42 AM.",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

// this widget shows information and other parameters about the charger.
class informationWidget extends StatefulWidget {
  final VoidCallback onButtonPressed;
  const informationWidget({Key? key, required this.onButtonPressed})
      : super(key: key);

  @override
  State<informationWidget> createState() => _informationWidgetState();
}

class _informationWidgetState extends State<informationWidget> {
  Swiper imageSlider(context) {
    return new Swiper(
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: widget.onButtonPressed,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
              gradient: const SweepGradient(
                  center: FractionalOffset.bottomRight,
                  colors: <Color>[
                    Colors.grey,
                    Colors.black,
                    Colors.grey,
                  ],
                  stops: [
                    0.2,
                    0.3,
                    0.7
                  ]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    informationObject[index]['title'].toString(),
                    style: headerText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey.shade300),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Icon(
                        informationObject[index]['icons'],
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    informationObject[index]['value'].toString() +
                        " " +
                        informationObject[index]['unit'].toString(),
                    style: headerText,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: 4,
      viewportFraction: 0.7,
      scale: 0.8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        alignment: Alignment.center,
        constraints: BoxConstraints.expand(height: 200),
        child: imageSlider(context));
  }
}
