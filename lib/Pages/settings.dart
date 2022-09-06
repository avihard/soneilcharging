import 'package:flutter/material.dart';

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.blue.shade800,
              ),
              Positioned(
                top: 20,
                child: Row(
                  children: const [
                    CircleAvatar(
                      radius: 144 / 2,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          "https://static.vecteezy.com/system/resources/previews/002/002/403/non_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Username",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
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
