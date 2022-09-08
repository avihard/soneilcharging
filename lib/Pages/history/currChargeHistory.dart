import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../helpers/constant.dart';

class currChargeHistoryWidget extends StatefulWidget {
  const currChargeHistoryWidget({Key? key}) : super(key: key);

  @override
  State<currChargeHistoryWidget> createState() =>
      _currChargeHistoryWidgetState();
}

class _currChargeHistoryWidgetState extends State<currChargeHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                      "Charging History",
                      style: headerText,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                chargingStatusWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class chargingStatusWidget extends StatefulWidget {
  const chargingStatusWidget({Key? key}) : super(key: key);

  @override
  State<chargingStatusWidget> createState() => _chargingStatusWidgetState();
}

class _chargingStatusWidgetState extends State<chargingStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Charge Limit",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "100%",
                        style: modelSubHeader,
                      )
                    ],
                  ),
                  const VerticalDivider(
                    color: Colors.black54,
                    thickness: 2,
                  ),
                  Column(
                    children: [
                      const Text(
                        "Estimated",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "20:56",
                        style: modelSubHeader,
                      )
                    ],
                  ),
                ],
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.ev_station_sharp,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    "Plugged in",
                    style: modelText,
                  ),
                  const Text(
                    "90% / 100mh",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
        const Align(
            alignment: Alignment.center,
            widthFactor: 5,
            child: Icon(Icons.keyboard_double_arrow_down)),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.control_point,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Chaging Started",
                style: modelText,
              )
            ],
          ),
        ),
        const Align(
            alignment: Alignment.center,
            widthFactor: 5,
            child: Icon(Icons.keyboard_double_arrow_down)),
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.charging_station,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Charging...",
                style: modelText,
              )
            ],
          ),
        ),
        const Align(
            alignment: Alignment.center,
            widthFactor: 5,
            child: Icon(Icons.keyboard_double_arrow_down)),
        const Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          child: Text(
            'Target',
            style: TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
