import 'package:flutter/material.dart';
import '../helpers/utils.dart';

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
          Align(heightFactor: 5, child: personalInfoWidget())
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
    );
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
    return Column(
      children: [
        ElevatedButton(
            onPressed: () => {
                  setLoginStatus(false),
                  Navigator.of(context).popUntil((route) => false),
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false)
                },
            child: const Text("LOGOUT"))
      ],
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
