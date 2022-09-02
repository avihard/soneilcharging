import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../helpers/constant.dart';

class myProfileWidget extends StatelessWidget {
  const myProfileWidget({Key? key}) : super(key: key);

  Widget stopChargingButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black87,
        minimumSize: const Size.fromHeight(50), // NEW
        elevation: 10,
      ),
      onPressed: () {},
      child: const Text(
        'STOP CHARGING',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "Configuration",
                style: headerText,
              ),
              const SizedBox(
                height: 20,
              ),
              stopChargingButton(),
              const Divider(
                thickness: 1,
                height: 30,
                color: Colors.white,
              ),
              const chargeSettingWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class chargeSettingWidget extends StatefulWidget {
  const chargeSettingWidget({Key? key}) : super(key: key);

  @override
  State<chargeSettingWidget> createState() => _chargeSettingWidgetState();
}

class _chargeSettingWidgetState extends State<chargeSettingWidget> {
  int currentValue = 32;
  int maxCharging = 100;

  bool isAutoStart = true;

  Widget modalButtons(updateValues) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style:
              ElevatedButton.styleFrom(primary: Colors.black87, elevation: 0),
          onPressed: updateValues,
          child: const Text(
            'Update',
            style: TextStyle(fontSize: 16),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.white, elevation: 0),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: modelText,
          ),
        ),
      ],
    );
  }

  Widget editChargeSetting() {
    int _currvalue = currentValue;
    int _maxchargevalue = maxCharging;

    void updateValues() {
      setState(() {
        currentValue = _currvalue;
        maxCharging = _maxchargevalue;
      });
      Navigator.pop(context);
    }

    return BottomSheet(
        enableDrag: false,
        onClosing: () {
          print("hello");
        },
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Edit Charge Settings",
                      style: modelHeader,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        // Current Block
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Current",
                              style: modelSubHeader,
                            ),
                            Text(
                              "${_currvalue}A",
                              style: modelText,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "0",
                              style: modelText,
                            ),
                            Expanded(
                              child: Slider(
                                  value: _currvalue.toDouble(),
                                  min: 0.0,
                                  max: 32.0,
                                  thumbColor: Colors.grey,
                                  activeColor: Colors.black,
                                  inactiveColor: Colors.grey,
                                  label: 'Current',
                                  onChanged: (double newValue) {
                                    setState(() {
                                      _currvalue = newValue.toInt();
                                    });
                                  },
                                  semanticFormatterCallback: (double newValue) {
                                    return '${newValue.round()} A';
                                  }),
                            ),
                            Text(
                              "32",
                              style: modelText,
                            )
                          ],
                        ),
                        // Charging Block
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Max Charging",
                              style: modelSubHeader,
                            ),
                            Text(
                              "$_maxchargevalue%",
                              style: modelText,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "0",
                              style: modelText,
                            ),
                            Expanded(
                              child: Slider(
                                  value: _maxchargevalue.toDouble(),
                                  min: 0.0,
                                  max: 100.0,
                                  thumbColor: Colors.grey,
                                  activeColor: Colors.black,
                                  inactiveColor: Colors.grey,
                                  label: 'Current',
                                  onChanged: (double newValue) {
                                    setState(() {
                                      _maxchargevalue = newValue.toInt();
                                    });
                                  },
                                  semanticFormatterCallback: (double newValue) {
                                    return '${newValue.round()} %';
                                  }),
                            ),
                            Text(
                              "100",
                              style: modelText,
                            )
                          ],
                        ),
                        modalButtons(updateValues),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget chargeSettingRow(text, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: settingText,
        ),
        Text(
          value,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Charging Settings",
                style: tableTitle,
                textAlign: TextAlign.start,
              ),
              InkWell(
                onTap: () => {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [editChargeSetting()],
                        );
                      }),
                },
                child: const Text(
                  "Edit",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          chargeSettingRow("Current", currentValue.toString()),
          const Divider(
            height: 20,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          chargeSettingRow("Voltage", "210"),
          const Divider(
            height: 20,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          chargeSettingRow("Max Charge", maxCharging.toString()),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "AutoStart",
                style: tableTitle,
                textAlign: TextAlign.start,
              ),
              Switch(
                activeColor: Colors.blue.shade800,
                value: isAutoStart,
                onChanged: (value) => {
                  setState(
                    () => {isAutoStart = value},
                  ),
                },
              ),
            ],
          ),
          const Text(
            "Enabling Autostart will start the charging as soon as you plug the charger to the car.",
            style: TextStyle(color: Colors.grey),
          )
          /* for wifi enable and disable*/
          /* RaisedButton(
            child: Text("Enable"),
            onPressed: () {
              if (Platform.isAndroid) {
                setState(() {
                  WiFiForIoTPlugin.setEnabled(false, shouldOpenSettings: true);
                });
              }
            },
          ), */
        ],
      ),
    );
  }
}
