import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:intl/intl.dart';
import '../../helpers/constant.dart';
import '../../helpers/utils.dart';
import '../../interface/chargingHistoryInterface.dart';

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

final Map<int, List<chargingHistoryInterface>> monthChargingList = {};

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
  final scrollController = SwiperControl();
  int remainingMonth = 12 - DateTime.now().month;
  int selectedIndex = 0;
  String selectedMonth = '';

  // selected months charging List
  List<chargingHistoryInterface> listofCharging = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = months.length - remainingMonth - 1;

    fillChargingHistory();

    listofCharging = monthChargingList[selectedIndex]!;

    // this is just for testing purpose
    writeCounter("test.txt", "ss");
  }

  void fillChargingHistory() {
    for (var i = 0; i < months.length; i++) {
      chargingHistoryInterface chargeHistory =
          chargingHistoryInterface(7.83, 4.00, "07-01-2022", "08:00", "13:00");
      if (monthChargingList.isEmpty || monthChargingList[i] == null) {
        monthChargingList[i] = [];
      }
      monthChargingList[i]?.add(chargeHistory);
    }
  }

  Widget chargeRowElem(label, value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            textAlign: TextAlign.left,
          ),
          Text(
            value,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    readCounter("test.txt");
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.black45),
              child: Swiper(
                control: scrollController,
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
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: listofCharging.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: ExpansionTile(
                      //initiallyExpanded: selected,
                      //key: GlobalKey(),
                      title: Text(listofCharging[index].chargingDate),
                      //trailing: Text(widget.setTimes[index]['time'].format(context)),
                      /* onExpansionChanged: (value) {
                        return value ? _selectTime(index) : null;
                      }, */
                      children: [
                        SizedBox(
                          height: 140,
                          width: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              chargeRowElem("Start Time",
                                  listofCharging[index].startTime),
                              chargeRowElem(
                                  "End Time", listofCharging[index].endTime),
                              chargeRowElem(
                                  "Cost",
                                  listofCharging[index]
                                      .chargingPrice
                                      .toString()),
                              chargeRowElem(
                                  "Date", listofCharging[index].chargingDate),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
