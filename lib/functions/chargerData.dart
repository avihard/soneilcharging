import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../helpers/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';

class chargerDataWidget extends StatefulWidget {
  const chargerDataWidget({Key? key}) : super(key: key);

  @override
  State<chargerDataWidget> createState() => _chargerDataWidgetState();
}

class _chargerDataWidgetState extends State<chargerDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "Data",
                  style: headerText,
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 40,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CarouselSlider(
              items: <Widget>[
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 40.0,
                  runSpacing: 20.0,
                  children: <Widget>[
                    _infoCard('Status'),
                    _infoCard('Chemistry'),
                    _infoCard('Time(hh:mm)'),
                    _infoCard('Voltage(V)'),
                    _infoCard('Current(A)'),
                    _infoCard('Cycles'),
                  ],
                ),
                _chargeHistory(),
              ],
              options: CarouselOptions(
                height: 400,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                initialPage: 0,
                reverse: false,
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _infoCard(String category) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        const Color(0xFF3366FF),
        const Color(0xFF00CCFF),
      ]),
      shape: BoxShape.rectangle,
      color: Colors.blue.shade400,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.shade400,
          blurRadius: 2,
          offset: const Offset(0, 2), // Shadow position
        ),
      ],
    ),
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.only(top: 20),
    width: 120,
    height: 110,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Text(category,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Text("Here",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white)),
                  ],
                ),
              )
            ],
          ),
        ]),
    //child: Center(child: Text(text)),
  );
}

Widget _chargeHistory() {
  return SingleChildScrollView(
    child: Column(
      children: [
        Text("Charging History", style: tableTitle),
        DataTable(columns: [
          DataColumn(
            label: Text('ID'),
          ),
          DataColumn(
            label: Text('Name'),
          ),
          DataColumn(
            label: Text('Code'),
          ),
          DataColumn(
            label: Text('Quantity'),
          ),
          DataColumn(
            label: Text('Amount'),
          ),
        ], rows: [
          for (var i = 0; i < 10; i++)
            DataRow(
              cells: [
                DataCell(Text(i.toString())),
                DataCell(Text('Arshik')),
                DataCell(Text('5644645')),
                DataCell(Text('3')),
                DataCell(Text('265\$')),
              ],
            ),
        ]),
      ],
    ),
  );
}
