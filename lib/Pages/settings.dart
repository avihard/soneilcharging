import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        crossAxisAlignment: CrossAxisAlignment.end,
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
                          width: 10,
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

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
