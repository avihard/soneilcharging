import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soneilcharging/functions/calendar/calendar_popup_view.dart';
import 'package:soneilcharging/helpers/constant.dart';

class Records extends StatefulWidget {
  const Records({Key? key}) : super(key: key);

  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  final termFlags = {
    1: "Pause",
    2: "Discontinued",
    3: "Charged",
    4: "Error",
    5: "Unknown",
  };

  final _scrollController = ScrollController();
  final DateTime currentDateTime = DateTime.now();

  DateTime startDate = DateTime.now().add(const Duration(days: -10));
  DateTime endDate = DateTime.now();

  int _currentPage = 1;
  final pageSize = 10;
  bool isDataLoading = false;

  // Temporary data storage variable.
  List fakeData = [];
  // this var is for storing all the data from server.
  List _data = [];

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Charging History",
                style: headerText,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    showDateTimeDialog(context: context);
                  },
                  child: DateAndTimeWidget()),
              ElevatedButton(
                child: Text(
                  "Get History!!",
                  style: normalTexts,
                ),
                onPressed: () => _getHistoryData(startDate, endDate, 1),
              ),
              RecordsList(context: context)
            ],
          ),
        ),
      ),
    );
  }

// ************* List of records widget *************

  Widget RecordsList({required BuildContext context}) {
    return Expanded(
      child: ListView.builder(
          controller: _scrollController,
          itemCount: isDataLoading ? _data.length + 1 : _data.length,
          itemBuilder: (context, i) {
            if (i < _data.length) {
              return ExpansionTile(
                leading: Text(
                  _data[i]['startHeader'],
                  style: smallTexts,
                ),
                title: Center(
                    child: Text(
                  _data[i]['powerHeader'].toString(),
                  style: smallTexts,
                )),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _data[i]['costHeader'].toString(),
                        style: smallTexts,
                      ),
                      Icon(Icons.arrow_drop_down_sharp)
                    ],
                  ),
                ),
                children: [
                  ListTile(
                    title: Text(_data[i]['durationHeader']),
                    trailing: Text(
                        termFlags[int.parse(_data[i]['reasonHeader'])]
                            .toString()),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

// ************* choose dates widget ***************

  Widget DateAndTimeWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Choose dates',
            style: smallTexts,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
              '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
              style: smallTexts),
        ],
      ),
    );
  }

// ************* calender show functions ***************

  void showDateTimeDialog({BuildContext? context}) {
    showDialog<dynamic>(
        context: context!,
        builder: (BuildContext context) => CalendarPopupView(
              minimumDate: DateTime(currentDateTime.year - 1,
                  currentDateTime.month, currentDateTime.day),
              barrierDismissible: true,
              maximumDate: currentDateTime,
              initialEndDate: currentDateTime,
              initialStartDate: DateTime(currentDateTime.year,
                  currentDateTime.month, currentDateTime.day - 10),
              onApplyClick: (DateTime startData, DateTime endData) {
                setState(() {
                  startDate = startData;
                  endDate = endData;
                });
              },
              onCancelClick: () {},
            ));
  }

  void _getHistoryData(DateTime startDate, DateTime endDate, int pageId) {
// ********* Put api call here for history data ********

    var data =
        "2023-01-02;100;3;10.2;190\n2023-01-04;170;2;17.2;250\n2023-01-12;50;4;5;90\n2023-01-02;100;3;10.2;190\n2023-01-04;170;2;17.2;250\n2023-01-12;50;4;5;90\n2023-01-02;100;3;10.2;190\n2023-01-04;170;2;17.2;250\n2023-01-12;50;4;5;90\n2023-01-02;100;3;10.2;190\n2023-01-04;170;2;17.2;250\n2023-01-12;50;4;5;90\n2023-01-02;100;3;10.2;190\n2023-01-04;170;2;17.2;250\n2023-01-12;50;4;5;90";
    var records = data.split("\n");

    for (var data in records) {
      var singleEntity = data.split(";");
      fakeData.add({
        'startHeader': singleEntity[0],
        'durationHeader': _durationToString(int.parse(singleEntity[1])),
        'reasonHeader': singleEntity[2],
        'powerHeader': singleEntity[3],
        'costHeader': singleEntity[4]
      });
    }
    setState(() {
      _data = _data + fakeData;
    });
  }

  String _durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }

  void _scrollListener() {
    if (isDataLoading) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        isDataLoading = true;
      });
      _currentPage = _currentPage + 1;
      _getHistoryData(startDate, endDate, _currentPage);
      setState(() {
        isDataLoading = false;
      });
    }
  }
}
