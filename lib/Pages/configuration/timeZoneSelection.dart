import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:soneilcharging/helpers/constant.dart';
import 'package:soneilcharging/helpers/timeZone.dart';

class timeZoneSelection extends StatefulWidget {
  const timeZoneSelection({Key? key}) : super(key: key);

  @override
  State<timeZoneSelection> createState() => _timeZoneSelectionState();
}

class _timeZoneSelectionState extends State<timeZoneSelection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
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
                    "Time Zone Selection",
                    style: headTexts,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: timeZone.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(timeZone[i]['label'].toString()),
                      onTap: () {
                        Navigator.pop(context, timeZone[i]);
                      },
                    );
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
