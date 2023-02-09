import 'package:flutter/material.dart';
import 'package:soneilcharging/Pages/record/records.dart';
import 'package:soneilcharging/Pages/settings/addedVehiclesList.dart';
import 'package:soneilcharging/Pages/settings/setTimingHours.dart';
import '../../helpers/constant.dart';
import '../../helpers/utils.dart';
import 'deviceSettings.dart';
import 'editInformation.dart';

class settingWidget extends StatefulWidget {
  const settingWidget({Key? key}) : super(key: key);

  @override
  State<settingWidget> createState() => _settingWidgetState();
}

class _settingWidgetState extends State<settingWidget> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 100.0)),
                ),
              ),
              Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      children: const [
                        CircleAvatar(
                          radius: 144 / 2,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                              "https://static.vecteezy.com/system/resources/previews/002/002/403/non_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Jeet",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Align(heightFactor: 1.5, child: personalInfoWidget())
          /* Text(counter.toString()),
          ElevatedButton(
              child: const Text("Press me"),
              onPressed: () => {
                    setState(() => {counter++}),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const directtome()))
                  }), */
        ],
      ),
    ));
  }
}

class personalInfoWidget extends StatefulWidget {
  const personalInfoWidget({Key? key}) : super(key: key);

  @override
  State<personalInfoWidget> createState() => _personalInfoWidgetState();
}

class _personalInfoWidgetState extends State<personalInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Information",
                      style: headTexts,
                    ),
                    InkWell(
                      child: const Text(
                        "Edit",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => editPersonalInfo()))
                      },
                    )
                  ],
                ),
                Divider(
                  height: 10,
                  color: Colors.blue.shade800,
                  thickness: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 32,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        const Text("Username"),
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "dev1ceee",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 32,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Email"),
                        SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "vyasjeet13@gmail.com",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          DeviceSettingWidget(),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ElevatedButton(
                onPressed: () => {
                      setLoginStatus(false),
                      Navigator.of(context).popUntil((route) => false),
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route<dynamic> route) => false)
                    },
                child: const Text("LOGOUT")),
          ),
        ],
      ),
    );
  }
}

class directtome extends StatefulWidget {
  const directtome({Key? key}) : super(key: key);

  @override
  State<directtome> createState() => _directtomeState();
}

class _directtomeState extends State<directtome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
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
              const Text(
                "Settings",
                textAlign: TextAlign.center,
              )
            ],
          )
        ],
      ),
    ));
  }
}

// device settings section
class DeviceSettingWidget extends StatefulWidget {
  const DeviceSettingWidget({Key? key}) : super(key: key);

  @override
  State<DeviceSettingWidget> createState() => _DeviceSettingWidgetState();
}

class _DeviceSettingWidgetState extends State<DeviceSettingWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Charging & Device Settings",
            style: normalTexts,
          ),
          Divider(
            height: 10,
            color: Colors.blue.shade800,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(createRoute(DeviceInfoWidget()));
              },
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Device Settings',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(createRoute(addedVehiclesListWidget()));
              },
              child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Added Vehicles',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(createRoute(TimingHrsWidget()));
              },
              child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Set Charging Times',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(createRoute(Records()));
              },
              child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Charging History',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
