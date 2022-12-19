import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../helpers/constant.dart';
import '../serivces/globalVars.dart';

class myProfileWidget extends StatelessWidget {
  final GlobalKey<_chargeSettingWidgetState> _myWidgetState =
      GlobalKey<_chargeSettingWidgetState>();
  myProfileWidget({Key? key}) : super(key: key);

  Widget resetChargingButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue.shade800,
        minimumSize: const Size.fromHeight(50), // NEW
        elevation: 10,
      ),
      onPressed: () {
        _myWidgetState.currentState?.resetSettings();
      },
      child: const Text(
        'Reset to Default',
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Configuration",
                style: headerText,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 1,
                height: 30,
                color: Colors.white,
              ),
              chargeSettingWidget(key: _myWidgetState),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: resetChargingButton(),
              ),
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

class _chargeSettingWidgetState extends State<chargeSettingWidget>
    with AutomaticKeepAliveClientMixin<chargeSettingWidget> {
  @override
  bool get wantKeepAlive => true;

  late double currentValue;
  late int maxCharging;
  late double voltValue;

  globalVars _myService = globalVars();

  bool isAutoStart = true;
  bool isEcoCharging = true;

  // this funtion resets the settings
  void resetSettings() {
    setState(() {
      currentValue = 32;
      maxCharging = 100;
      voltValue = 240;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentValue = _myService.currentLevel;
    maxCharging = _myService.targetBatteryLevel;
    voltValue = _myService.voltLevel;
    isEcoCharging = _myService.ecoCharging;
  }

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
    double _currvalue = currentValue;
    int _maxchargevalue = maxCharging;
    double _voltvalue = voltValue;

    void updateValues() {
      // updating global variables
      _myService.setCurrentLevel(_currvalue);
      _myService.setVoltLevel(_voltvalue);
      _myService.setTargetBatteryLevel(_maxchargevalue);
      setState(() {
        currentValue = _currvalue;
        maxCharging = _maxchargevalue;
        voltValue = _voltvalue;
      });
      Navigator.pop(context);
    }

    return BottomSheet(
        enableDrag: false,
        onClosing: () {},
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
                                      _currvalue = newValue;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Voltage",
                              style: modelSubHeader,
                            ),
                            Text(
                              "${_voltvalue} V",
                              style: modelText,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "110",
                              style: modelText,
                            ),
                            Expanded(
                              child: Slider(
                                  value: _voltvalue.toDouble(),
                                  min: 110.0,
                                  max: 240.0,
                                  thumbColor: Colors.grey,
                                  activeColor: Colors.black,
                                  inactiveColor: Colors.grey,
                                  label: 'Voltage',
                                  onChanged: (double newValue) {
                                    setState(() {
                                      _voltvalue = newValue;
                                    });
                                  },
                                  semanticFormatterCallback: (double newValue) {
                                    return '${newValue.round()} A';
                                  }),
                            ),
                            Text(
                              "240",
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
    super.build(context);
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
          chargeSettingRow("Voltage", voltValue.toString()),
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
                "Charge Immediately",
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Eco-charging",
                style: tableTitle,
                textAlign: TextAlign.start,
              ),
              Switch(
                activeColor: Colors.blue.shade800,
                value: isEcoCharging,
                onChanged: (value) => {
                  setState(
                    () => {
                      isEcoCharging = value,
                      _myService.setEcoCharging(isEcoCharging)
                    },
                  ),
                },
              ),
            ],
          ),
          const Text(
            "Enabling eco charging will make sure that when electricity prices are at lowest, the current and voltage will be set to maximum for fast charging.",
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
