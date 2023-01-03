import 'package:flutter/material.dart';
import '../../helpers/constant.dart';
import '../../helpers/inputStyleWidget.dart';
import '../../helpers/utils.dart';

class selectedCarInformationWidget extends StatefulWidget {
  final dynamic carInfo;
  final Function function;
  final Function removeItem;
  const selectedCarInformationWidget(
      {Key? key,
      required this.carInfo,
      required this.function,
      required this.removeItem})
      : super(key: key);

  @override
  State<selectedCarInformationWidget> createState() =>
      _selectedCarInformationWidgetState();
}

class _selectedCarInformationWidgetState
    extends State<selectedCarInformationWidget> {
  final _formKey = GlobalKey<FormState>();

  // all fields controller
  TextEditingController nameController = TextEditingController();
  TextEditingController accelerateController = TextEditingController();
  TextEditingController speedController = TextEditingController();
  TextEditingController rangeController = TextEditingController();
  TextEditingController efficientController = TextEditingController();
  TextEditingController fastChargeController = TextEditingController();

  Future deleteItemPopup(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.zero,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Delete Item"),
            ]),
        content: Container(
          width: MediaQuery.of(context).size.width - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Are you sure you want to remove this item from your list?")
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  widget.removeItem(widget.carInfo['Id']);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  showSnackBar(context, "Item Deleted!!");
                },
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              )
            ],
          )
        ],
      ),
    );
  }

  Future editItem(context) {
    nameController.text = widget.carInfo["carName"];
    accelerateController.text = widget.carInfo["Acceleration"];
    speedController.text = widget.carInfo["TopSpeed"];
    rangeController.text = widget.carInfo["Driving Range"];
    efficientController.text = widget.carInfo["Efficiency"];
    fastChargeController.text = widget.carInfo["FastCharge"];

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        insetPadding: EdgeInsets.zero,
        title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Your car details"),
              const Text(
                "Change these values based on your car model.",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ]),
        content: Container(
          width: MediaQuery.of(context).size.width - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelAndValue("Maker", widget.carInfo['Maker']),
              SizedBox(
                height: 10,
              ),
              labelAndValue("Model", widget.carInfo['Model']),
              SizedBox(
                height: 10,
              ),
              labelAndValue("Year", widget.carInfo['Year']),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    carInfoBoxes("Car Name", nameController),
                    SizedBox(
                      height: 10,
                    ),
                    carInfoBoxes("Acceleration", accelerateController),
                    SizedBox(
                      height: 10,
                    ),
                    carInfoBoxes("Top Speed", speedController),
                    SizedBox(
                      height: 10,
                    ),
                    carInfoBoxes("Driving Range", rangeController),
                    SizedBox(
                      height: 10,
                    ),
                    carInfoBoxes("EVSE Efficiency", efficientController),
                    SizedBox(
                      height: 10,
                    ),
                    carInfoBoxes("Fast Charge Speed", fastChargeController),
                  ],
                ),
              )
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      widget.carInfo["carName"] = nameController.text;
                      widget.carInfo['Acceleration'] =
                          accelerateController.text;
                      widget.carInfo['TopSpeed'] = speedController.text;
                      widget.carInfo['Driving Range'] = rangeController.text;
                      widget.carInfo['Efficiency'] = efficientController.text;
                      widget.carInfo['FastCharge'] = fastChargeController.text;
                    });
                    widget.function();
                    Navigator.of(context).pop();
                    showSnackBar(context, "Item Updated.");
                  }
                },
                child: Text("Submit"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget carInfoRow(label, value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: Text(
            label,
            style: TextStyle(
                color: Colors.grey.shade400, fontWeight: FontWeight.bold),
          )),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget showCarInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        carInfoRow("Maker", widget.carInfo["Maker"]),
        carInfoRow("Model", widget.carInfo["Model"]),
        carInfoRow("Year", widget.carInfo["Year"]),
        //carInfoRow("Miles", widget.carInfo["Miles"]),
        carInfoRow("carName", widget.carInfo["carName"]),
        carInfoRow("Acceleration", widget.carInfo["Acceleration"]),
        carInfoRow("TopSpeed", widget.carInfo["TopSpeed"]),
        carInfoRow("Driving Range", widget.carInfo["Driving Range"]),
        carInfoRow("Efficiency", widget.carInfo["Efficiency"]),
        carInfoRow("FastCharge", widget.carInfo["FastCharge"]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade900,
                elevation: 10,
              ),
              onPressed: () {
                editItem(context);
              },
              child: const Text(
                'Edit',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                hoverColor: Colors.blue,
                focusColor: Colors.blue,
                child: const Icon(
                  Icons.keyboard_arrow_left,
                  size: 32,
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: widget.carInfo['carName'], style: headTexts),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                hoverColor: Colors.blue,
                focusColor: Colors.blue,
                child: const Icon(
                  Icons.delete,
                  size: 28,
                ),
                onTap: () => {
                  deleteItemPopup(context),
                },
              ),
            ],
          ),
          showCarInfo(),
        ],
      ),
    )));
  }
}
