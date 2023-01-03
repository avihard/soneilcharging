import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soneilcharging/helpers/utils.dart';

import '../../helpers/constant.dart';

class DeviceInfoWidget extends StatefulWidget {
  const DeviceInfoWidget({Key? key}) : super(key: key);

  @override
  State<DeviceInfoWidget> createState() => _DeviceInfoWidgetState();
}

class _DeviceInfoWidgetState extends State<DeviceInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(children: [
              Row(
                children: [
                  Material(
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12))),
                      child: InkWell(
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        onTap: () => {Navigator.pop(context)},
                      ),
                    ),
                  ),
                  Text(
                    "Device Settings",
                    style: headTexts,
                  )
                ],
              ),
              chargerInfoWidget()
            ]),
          ),
        ),
      ),
    );
  }
}

class chargerInfoWidget extends StatefulWidget {
  const chargerInfoWidget({Key? key}) : super(key: key);

  @override
  State<chargerInfoWidget> createState() => _chargerInfoWidgetState();
}

class _chargerInfoWidgetState extends State<chargerInfoWidget> {
  // common widget to display label and the textbox
  Widget showLabelandText(label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.blue.shade800),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          initialValue: "dev1ceee",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        child: Column(
          children: [
            showLabelandText("Charger Name"),
            SizedBox(
              height: 20,
            ),
            showLabelandText("Charger Version"),
            SizedBox(
              height: 10,
            ),
            showLabelandText("Maximum Charging rate"),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                      onPressed: () => {
                            // API call here to save the data
                            showSnackBar(context, "Profile Updated"),
                            Navigator.of(context).pop()
                          },
                      child: const Text("Save")),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent, // NEW
                          visualDensity: VisualDensity.comfortable),
                      onPressed: () => {Navigator.of(context).pop()},
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
