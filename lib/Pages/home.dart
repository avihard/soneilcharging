// ignore_for_file: unnecessary_new

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:battery/battery.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../helpers/constant.dart';
import '../helpers/utils.dart';
import '../serivces/globalVars.dart';
import 'chargerAdd/addChargerMsg.dart';
import 'history/chargeHistoryList.dart';
import 'history/currChargeHistory.dart';
import 'dart:convert';
import 'package:soneilcharging/my_flutter_app_icons.dart';

const dynamic informationObject = [
  {
    "title": "Current",
    "value": 32,
    "unit": "A",
    "icons": MyFlutterApp.flash_auto
  },
  {
    "title": "Voltage",
    "value": 205,
    "unit": "V",
    "icons": Icons.electric_meter
  },
  {
    "title": "Temperature",
    "value": 26,
    "unit": "*C",
    "icons": Icons.thermostat
  },
  {"title": "Cycle", "value": 4, "unit": "", "icons": Icons.loop},
  {"title": "Set Current", "value": 4, "unit": "A", "icons": Icons.volcano},
  {"title": "Power", "value": 4, "unit": "kw", "icons": Icons.power},
  {
    "title": "Energy",
    "value": 4,
    "unit": "kwh",
    "icons": Icons.energy_savings_leaf_outlined
  }
];

// chargingStatus Number
Map<String, dynamic> statusMap = {"status": 0};

// singleton service
globalVars _myService = globalVars();

//saving into the local file of the device
void saveChargeStatus(status) async {
  var response = null;
  if (status == 1) {
    response = await http.get(Uri.parse('chargePause'));
  } else {
    response = await http.get(Uri.parse('chargeResume'));
  }

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    statusMap['status'] = status;
    final jsonStr = jsonEncode(statusMap);

    // writing the saved vehicle data to localfile
    writeCounter("chargingStatus.txt", jsonStr);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw 'failed';
  }
}

// reading from localfile
void readChargeStatus() async {
  String jsonStr = await readCounter("chargingStatus.txt");
  // reading from file and setting our local map to it

  //addedVehicles = jsonDecode(jsonStr);
}

class HomeWidget extends StatefulWidget {
  final VoidCallback onButtonPressed;
  const HomeWidget({Key? key, required this.onButtonPressed}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool isChargerAdded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChargerAdded = _myService.isCharger;
  }

  Stream<Map<String, dynamic>> getData() async* {
    yield* Stream.fromFuture(fetchAlbum());
    yield* Stream.periodic(const Duration(seconds: 10), (_) {
      return fetchAlbum();
    }).asyncMap((event) async => await event);
  }

  Widget stopChargingButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(200, 50),
        primary: Colors.red.shade900,
        elevation: 10,
      ),
      onPressed: () {
        saveChargeStatus(1);
      },
      child: const Text(
        'STOP CHARGING',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget resumeChargingButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(200, 50),
        primary: Colors.green.shade900,
        elevation: 10,
      ),
      onPressed: () {
        saveChargeStatus(2);
      },
      child: const Text(
        'RESUME CHARGING',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isChargerAdded) {
      return SafeArea(
        child: addChargerMsgWidget(),
      );
    } else {
      return StreamBuilder(
          stream: getData(),
          builder: (
            BuildContext context,
            AsyncSnapshot snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );

                // if we got our data
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      batteryWidget(snapshot: snapshot),
                      SizedBox(
                        height: 40,
                      ),
                      snapshot.data['Status'] == "Charging"
                          ? stopChargingButton()
                          : const Text(""),
                      snapshot.data['Status'] == "Paused"
                          ? resumeChargingButton()
                          : const Text(""),
                      informationWidget(
                          onButtonPressed: widget.onButtonPressed,
                          snapshot: snapshot),
                      // estimated time and price.
                      priceandtimeWidget(),
                    ],
                  ),
                );
              }
            }
            // Displaying LoadingSpinner to indicate waiting state
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    }
  }
}

// this widget shows battery charging information
class batteryWidget extends StatefulWidget {
  final AsyncSnapshot snapshot;
  const batteryWidget({Key? key, required this.snapshot}) : super(key: key);

  @override
  State<batteryWidget> createState() => _batteryWidgetState();
}

class _batteryWidgetState extends State<batteryWidget> {
  final battery = Battery();
  int batteryLevel = 70;
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
        '16 kWh / 10mih',
        style: TextStyle(
          fontSize: 24,
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
                Image.asset(
                  "assets/images/evcharger.gif",
                  height: 125.0,
                  width: 125.0,
                ),
                /* Icon(Icons.battery_charging_full_rounded,
                    size: size, color: color), */
              ],
            ),
            Text(widget.snapshot.data['Status'].toString(),
                style: style.copyWith(color: color)),
          ],
        );
      case BatteryState.charging:
        final color = Colors.yellow;

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
    // set data so that it can be used globally
    //_myService.setCurrentBatteryLevel(60);
    _myService.setCurrentLevel(double.parse(widget.snapshot.data['Current']));
    _myService.setVoltLevel(double.parse(widget.snapshot.data['Voltage']));
    _myService.setBatteryCapacity(100);
    _myService.setTargetBatteryLevel(100);
    _myService.setChargingStartTime(DateFormat("HH:mm").format(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 9)));

    return Column(
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
                padding: const EdgeInsets.only(
                    top: 50, bottom: 20, left: 20, right: 20),
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
                              builder: (context) => chargeHistoryListWidget()),
                        )
                      },
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Range Added"),
                        buildBatteryLevel(batteryLevel),
                      ],
                    )
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
                child: Text(
                  "Last Updated on " +
                      DateFormat('hh:mm a').format(DateTime.now()).toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// this widget shows information and other parameters about the charger.
class informationWidget extends StatefulWidget {
  final VoidCallback onButtonPressed;
  final AsyncSnapshot snapshot;
  const informationWidget(
      {Key? key, required this.onButtonPressed, required this.snapshot})
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
                    widget.snapshot.data[informationObject[index]['title']]
                            .toString() +
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
      itemCount: 7,
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

class priceandtimeWidget extends StatelessWidget {
  const priceandtimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: (MediaQuery.of(context).size.width / 2 -
                  18), // change this if you add padding
              height: 150,
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Estimated Time",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Text("00:15:00",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                ],
              )),
        ),
        Container(
          color: Colors.white,
          height: 100,
          width: 2,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: (MediaQuery.of(context).size.width / 2 -
                18), // change this if you add padding
            height: 150,
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Estimated Cost",
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text("4.65 CAD",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Map<String, dynamic> parseData(String data) {
  var s = data;
  String timeanddata = '',
      ipAddress = '',
      idValue = '',
      Volt = '',
      Current = '',
      Temperature = '',
      tempType = '',
      Curve = '',
      CurveTime = '',
      Cycle = '',
      Status = '',
      Rev = '',
      widthChart = '',
      chargerName = '',
      setCur = '',
      power = '',
      energy = '';

  var arrTxt = s.split(r'$$__');
  if (arrTxt.isNotEmpty) //datetime,tmON,Connection,macId-SN
  {
    var elValues = arrTxt[0].split(',');
    if (elValues.isNotEmpty) {
      var datendtime = elValues[0].split(":");
      timeanddata =
          "${datendtime[0]}:${datendtime[1]}:${datendtime[2]} ${datendtime[3]}:${datendtime[4]}:${datendtime[5]}";
    }
    //if (elValues.length > 1)
    //    document.getElementById("ON_TIME").innerHTML = elValues[1];
    if (elValues.length > 2) {
      ipAddress = elValues[2];
    }
    if (elValues.length > 3) {
      idValue = (elValues[3].split("#")[1]).split("]")[0];
    }
  }
  if (arrTxt.length > 1) //volt,current,temp
  {
    var elValues = arrTxt[1].split(','); //this.responseText;
    if (elValues.isNotEmpty) {
      Volt = elValues[0];
    }
    if (elValues.length > 1) {
      Current = elValues[1];
    }
    if (elValues.length > 2) {
      Temperature = elValues[2];
    }
    if (elValues.length > 3) {
      tempType = elValues[3];
    }
  }
  if (arrTxt.length > 2) //selectedCurve,tmCurve,cycle#,tmStage
  {
    var elValues = arrTxt[2].split(','); //this.responseText;
    if (elValues.isNotEmpty) {
      Curve = elValues[0];
    }
    if (elValues.length > 1) {
      CurveTime = elValues[1];
    }
    if (elValues.length > 2) {
      Cycle = elValues[2];
    }
    if (elValues.length > 3) {
      Status = elValues[3];
    }
    // this is only for ev chargers
    if (elValues.length > 4) {
      var evValues = elValues[4].split(":");
      setCur = evValues[0];
      power = evValues[1];
      energy = evValues[2];
    }
  }
  if (arrTxt.length > 3) //selectedCurve,tmCurve,cycle#,tmStage
  {
    var elValues = arrTxt[3].split(','); //this.responseText;
    if (elValues.isNotEmpty) {
      widthChart = elValues[0];
    }
  }
  if (arrTxt.length > 4) {
    var elValues = arrTxt[4].split(','); //this.responseText;
    if (elValues.isNotEmpty) {
      Rev = elValues[0];
    }
    if (elValues.length > 1) {
      var nameArr = elValues[1].split(" ");
      //chargerName = nameArr[0] + " " + nameArr[1] + " " + nameArr[2];
      //var singletonObject = Singleton();
      //singletonObject.setChargerName(chargerName);
    }
    /* if (elValues.length > 1) {
      let nameArr = elValues[1].split(" ");
      var chargname = document.getElementById("chargerName").innerHTML = nameArr[0]+ " "+ nameArr[1] + " <span class='color-text'>" + nameArr[2] + "</span>";
      sessionStorage.setItem("chargname", elValues[1]); 
    } */
  }
  DataInterface dataObject = DataInterface(
      timeanddata,
      ipAddress,
      idValue,
      Volt,
      Current,
      Temperature,
      tempType,
      Curve,
      CurveTime,
      Cycle,
      Status,
      Rev,
      widthChart,
      chargerName,
      setCur,
      power,
      energy);
  String jsonUser = jsonEncode(dataObject);

  Map<String, dynamic> dataMap = jsonDecode(jsonUser);
  var dataObjectValue = DataInterface.fromJson(dataMap);

  return dataMap;
}

// this class holds the value for data coming from API
class DataInterface {
  final String timeanddata,
      ipAddress,
      idValue,
      Volt,
      Current,
      Temperature,
      temp_type,
      Curve,
      Curve_time,
      Cycle,
      Status,
      Rev,
      widthChart,
      chargerName,
      setCur, // newly added
      power,
      energy;

  DataInterface(
      this.timeanddata,
      this.ipAddress,
      this.idValue,
      this.Volt,
      this.Current,
      this.Temperature,
      this.temp_type,
      this.Curve,
      this.Curve_time,
      this.Cycle,
      this.Status,
      this.Rev,
      this.widthChart,
      this.chargerName,
      this.setCur,
      this.power,
      this.energy);

  DataInterface.fromJson(Map<String, dynamic> json)
      : timeanddata = json['timeanddata'],
        ipAddress = json['ipAddress'],
        idValue = json['idValue'],
        Volt = json['Voltage'],
        Current = json['Current'],
        Temperature = json['Temperature'],
        temp_type = json['temp_type'],
        Curve = json['Curve'],
        Curve_time = json['Curve_time'],
        Cycle = json['Cycle'],
        Status = json['Status'],
        Rev = json['Rev'],
        widthChart = json['widthChart'],
        chargerName = json['chargerName'],
        setCur = json['setCur'],
        power = json['power'],
        energy = json['energy'];

  Map<String, dynamic> toJson() => {
        'timeanddata': timeanddata,
        'ipAddress': ipAddress,
        'idValue': idValue,
        'Voltage': Volt,
        'Current': Current,
        'Temperature': Temperature,
        'temp_type': temp_type,
        'Curve': Curve,
        'Curve_time': Curve_time,
        'Cycle': Cycle,
        'Status': Status,
        'Rev': Rev,
        'widthChart': widthChart,
        'chargerName': chargerName,
        'Set Current': setCur,
        'Power': power,
        'Energy': energy
      };
}

// API CALL
Future<Map<String, dynamic>> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('http://192.168.4.1/ajax_switch?p=1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> dataObjectValue = parseData(response.body);
    return dataObjectValue;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw 'failed';
  }
}
