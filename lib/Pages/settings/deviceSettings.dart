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
                  Expanded(
                    child: Text(
                      "Device Settings",
                      style: headTexts,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const chargerInfoWidget()
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
  TextEditingController nameController = TextEditingController();
  TextEditingController versionController = TextEditingController();
  TextEditingController maxChargeController =
      TextEditingController(text: "32.0");

  // common widget to display label and the textbox
  Widget showLabelandText(label, controller) {
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
          controller: controller,
          /* decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ), */
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text.';
            }
            return null;
          },
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
            showLabelandText("Charger Name", nameController),
            SizedBox(
              height: 20,
            ),
            showLabelandText("Charger Version", versionController),
            SizedBox(
              height: 10,
            ),
            showLabelandText("Maximum Charging rate", maxChargeController),
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
