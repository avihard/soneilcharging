import 'dart:convert';

import 'package:flutter/material.dart';

import '../../helpers/constant.dart';
import '../../helpers/utils.dart';
import 'selectedCarInformation.dart';

class addedVehiclesListWidget extends StatefulWidget {
  const addedVehiclesListWidget({Key? key}) : super(key: key);

  @override
  State<addedVehiclesListWidget> createState() =>
      _addedVehiclesListWidgetState();
}

class _addedVehiclesListWidgetState extends State<addedVehiclesListWidget> {
  Map<String, dynamic> addedVehicles = {};

  void removeItem(key) {
    addedVehicles.remove(key);
    saveAddedVehicle();
  }

  //saving into the local file of the device
  void saveAddedVehicle() {
    final jsonStr = jsonEncode(addedVehicles);
    // writing the saved vehicle data to localfile
    writeCounter("addedVehicles.txt", jsonStr);

    setState(() {});
  }

  // reading from localfile
  void readAddedVehicles() async {
    String jsonStr = await readCounter("addedVehicles.txt");

    // reading from file and setting our local map to it
    setState(() {
      addedVehicles = jsonDecode(jsonStr);
    });
    //addedVehicles = jsonDecode(jsonStr);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAddedVehicles();
  }

  Widget insertItem(key) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        InkWell(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    addedVehicles[key]!['carName'],
                    style: smallTexts,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 16.0,
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(createRouteAnim(
                selectedCarInformationWidget(
                    carInfo: addedVehicles[key],
                    function: saveAddedVehicle,
                    removeItem: removeItem)));
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                        TextSpan(text: "Your Added Vehicles", style: headTexts),
                      ],
                    ),
                  ),
                ],
              ),
              for (var elem in addedVehicles.keys) insertItem(elem)
            ],
          ),
        ),
      ),
    );
  }
}
