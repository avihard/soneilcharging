import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soneilcharging/helpers/constant.dart';
import 'package:soneilcharging/index.dart';
import '../../helpers/utils.dart';
import '../../serivces/globalVars.dart';
import 'addChargerPage.dart';

const List<String> list = <String>[
  'Charger 1',
  'Charger 2',
  'Charger 3',
  'Charger 4'
];

// singleton service
globalVars _myService = globalVars();

class addChargerMsgWidget extends StatelessWidget {
  const addChargerMsgWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Find your charger!!!",
            style: headTexts,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 150,
                child: Image.asset(
                  'assets/images/evcharge.png',
                  width: 210,
                  height: 210,
                ),
              ),
              const Text(
                  "Find your charger from the dropdown below, so you can access advanced features to control your charging.")
            ],
          ),
          // will create list of chargers to connect
          Container(
            width: 300,
            child: DropdownButtonFormField<String>(
              value: dropdownValue,
              elevation: 16,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.ev_station),
              ),
              onChanged: (String? value) {
                _myService.setIsCharger(true);
                Navigator.of(context).pop();
                Navigator.of(context).push(createRoute(indexWidget()));
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          /*  Container(
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade800,
                elevation: 10,
              ),
              onPressed: () {
                Navigator.of(context).push(createRoute(addChargerPageWidget()));
              },
              child: const Text("Add Charger"),
            ),
          ) */
        ],
      ),
    );
  }
}
