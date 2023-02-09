import 'package:flutter/material.dart';

import '../../helpers/constant.dart';

class TimingHrsWidget extends StatefulWidget {
  const TimingHrsWidget({Key? key}) : super(key: key);

  @override
  State<TimingHrsWidget> createState() => _TimingHrsWidgetState();
}

class _TimingHrsWidgetState extends State<TimingHrsWidget> {
  String countryValue = "Canada";
  String seasonValue = "Winter";
  String chargingUseValue = 'HouseHold';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      text: TextSpan(
                        children: [
                          TextSpan(text: "Set Timing Hours", style: headTexts),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Select your Country:"),
                    DropdownButton(
                      value: countryValue,
                      items: ['Canada', 'USA'].map((e) {
                        return DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          countryValue = value!;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Season:"),
                    DropdownButton(
                      value: seasonValue,
                      items: ['Winter', 'Summer'].map((e) {
                        return DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          seasonValue = value!;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Select Charging Purpose:"),
                    DropdownButton(
                      value: chargingUseValue,
                      items: ['Business', 'HouseHold'].map((e) {
                        return DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          chargingUseValue = value!;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "Time Chart (Mon - Fri)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                for (var v in electricityPrice.values)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(v['id']),
                        Row(
                          children: [
                            Text(v['startLabel']),
                            Text(" - "),
                            Text(v['endLabel']),
                          ],
                        )
                      ],
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                const Text("On weekends it is Off Peak all day.")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
