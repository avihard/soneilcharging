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
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
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
    return const Text("heyy");
  }
}
