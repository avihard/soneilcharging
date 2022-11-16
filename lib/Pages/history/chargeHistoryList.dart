import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../helpers/constant.dart';

final Map<int, String?> months = {
  0: "January",
  1: "Febraury",
  2: "March",
  3: "April",
  4: "May",
  5: "June",
  6: "July",
  7: "August",
  8: "September",
  9: "October",
  10: "November",
  11: "December"
};

class chargeHistoryListWidget extends StatefulWidget {
  const chargeHistoryListWidget({Key? key}) : super(key: key);

  @override
  State<chargeHistoryListWidget> createState() =>
      _chargeHistoryListWidgetState();
}

class _chargeHistoryListWidgetState extends State<chargeHistoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
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
                      TextSpan(text: "Charging History", style: headTexts),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0, left: 24.0),
              child: Text(
                "See all your charging history here. Click on them to get more details.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            chargingHistorySelectionWidget()
          ]),
        ),
      ),
    );
  }
}

class chargingHistorySelectionWidget extends StatefulWidget {
  const chargingHistorySelectionWidget({Key? key}) : super(key: key);

  @override
  State<chargingHistorySelectionWidget> createState() =>
      _chargingHistorySelectionWidgetState();
}

class _chargingHistorySelectionWidgetState
    extends State<chargingHistorySelectionWidget> {
  final scrollController = SwiperController();
  int remainingMonth = 12 - DateTime.now().month;
  int selectedIndex = 0;
  String selectedMonth = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = months.length - remainingMonth - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.black45),
            child: Swiper(
              controller: scrollController,
              viewportFraction: 0.5,
              itemCount: (months.length - remainingMonth),
              scrollDirection: Axis.horizontal,
              outer: true,
              itemHeight: 10,
              index: selectedIndex,
              onIndexChanged: (int Index) {
                selectedIndex = Index;
                setState(() {
                  selectedMonth = months[selectedIndex]!;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      months[index]!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
