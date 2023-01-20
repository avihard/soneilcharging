import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:soneilcharging/Authorization/forgotpassword.dart';
import 'package:soneilcharging/helpers/utils.dart';

import '../../helpers/commonWidgets.dart';
import '../../helpers/constant.dart';
import '../../helpers/carModels.dart';
import '../../helpers/inputStyleWidget.dart';

class addVehicle extends StatefulWidget {
  const addVehicle({Key? key}) : super(key: key);

  @override
  State<addVehicle> createState() => _addVehicleState();
}

class _addVehicleState extends State<addVehicle> {
  List<ImageProvider> imageList = <ImageProvider>[];

  var isLevel = 0;
  int selectedIndex = 0;
  final scrollController = SwiperController();
  List<dynamic> carModels = [];
  List<dynamic> yearArr = [];
  String _carModel = '';
  int selectedYear = 0;

  double carMileValue = 0;

  Map<String, dynamic> addedVehicles = {};

  // error and errorMsg
  bool isError = false;
  String errorMsg = '';

  // is other selected
  bool isOther = false;

  // bool to toggle if car has setup Miles or not
  bool isMiles = true;

  // textbox controller for 'others' option
  TextEditingController nameController = TextEditingController(text: "My car");
  TextEditingController valueController = TextEditingController();

  // car detail form
  TextEditingController accelerateController = TextEditingController();
  TextEditingController speedController = TextEditingController();
  TextEditingController rangeController = TextEditingController();
  TextEditingController efficientController = TextEditingController();
  TextEditingController fastChargeController = TextEditingController();

  // form key
  final _formKey = GlobalKey<FormState>();

  // form key for popup car info popup
  final _popupFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList.add(AssetImage('assets/images/tesla_car1.png'));

    //reading saved vehicles
    readAddedVehicles();
  }

  Widget showError() {
    return Text(
      errorMsg,
      style: TextStyle(color: Colors.red),
    );
  }

  Widget selectModel(List<dynamic> carModels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Select your car model",
        ),
        Container(
          // child: Dropdown,
          child: DropdownButton<dynamic>(
              items: carModels
                  .map((e) => DropdownMenuItem(
                        child: Text(
                          e['Model'],
                          style: TextStyle(fontSize: 11),
                        ),
                        value: e['Model'],
                      ))
                  .toList(),
              value: _carModel,
              onChanged: (value) {
                setState(() {
                  selectedYear = 0;
                  carMileValue = 0;
                  _carModel = value;
                });
              }),
        ),
      ],
    );
  }

  Widget showYearBlock(item) {
    return InkWell(
      child: Container(
        width: 50,
        height: 40,
        color: selectedYear == item ? Colors.blue.shade800 : Colors.black,
        child: Center(
          child: Text(
            item.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () => {
        setState(
          () => {
            selectedYear = item,
            isError = false,
            errorMsg = '',
            carMileValue = 0
          },
        )
      },
    );
  }

  Widget selectYear(List<dynamic> carModels) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Select Year"),
        SizedBox(
          height: 20,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceAround,
          spacing: 20,
          runSpacing: 10,
          children: [for (var item in yearArr[0]['Years']) showYearBlock(item)],
        )
      ],
    );
  }

  Widget showCustomForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (isMiles)
            /* Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Add your car name"),
                createInputBox(200.0, nameController)
              ],
            ), */
            SizedBox(
              height: 10,
            ),
        ],
      ),
    );
  }

  void addVehicles() {
    String idString =
        (brands[selectedIndex] + _carModel + selectedYear.toString())
            .toLowerCase()
            .trim();

    var itemToAdd = {
      'Id': idString,
      'Maker': brands[selectedIndex],
      'Model': _carModel,
      'Year': selectedYear.toString(),
      "Miles": valueController.text,
      "carName": nameController.text,
      "Acceleration": accelerateController.text,
      "TopSpeed": speedController.text,
      "Driving Range": rangeController.text,
      "Efficiency": efficientController.text,
      "FastCharge": fastChargeController.text
    };

    addedVehicles[idString] = itemToAdd;
  }

  // when user has selected other option
  void addOtherVehicle() {
    String idString = "Other_" + nameController.text;

    var itemToAdd = {
      'Id': idString,
      'Maker': idString,
      'Model': nameController.text,
      'Year': "N/A",
      'Miles': valueController.text
    };

    addedVehicles[idString] = itemToAdd;
  }

  //saving into the local file of the device
  void saveAddedVehicle() {
    final jsonStr = jsonEncode(addedVehicles);
    // writing the saved vehicle data to localfile
    writeCounter("addedVehicles.txt", jsonStr);
  }

  // reading from localfile
  void readAddedVehicles() async {
    String jsonStr = await readCounter("addedVehicles.txt");
    // reading from file and setting our local map to it
    setState(() {
      addedVehicles = jsonDecode(jsonStr);
    });
    //addedVehicles = jsonDecode(jsonStr);
  }

  // this funtion checks if the car mile value is present or not
  bool checkCarMileValue() {
    String idString =
        brands[selectedIndex] + "_" + _carModel + "_" + selectedYear.toString();
    if (carMiles[idString] != null || yearArr[0].length > 9) {
      carMileValue =
          carMiles[idString] != null ? carMiles[idString] : yearArr[0]['Miles'];
      return true;
    }

    return false;
  }

  Future openDialog(context) {
    accelerateController.text = yearArr[0]["Acceleration"] != null
        ? yearArr[0]["Acceleration"].toString()
        : "";
    speedController.text =
        yearArr[0]["TopSpeed"] != null ? yearArr[0]["TopSpeed"].toString() : "";
    rangeController.text =
        yearArr[0]["Range"] != null ? yearArr[0]["Range"].toString() : "";
    efficientController.text = yearArr[0]["Efficiency"] != null
        ? yearArr[0]["Efficiency"].toString()
        : "";
    fastChargeController.text = yearArr[0]["FastChargeSpeed"] != null
        ? yearArr[0]["FastChargeSpeed"].toString()
        : "";

    valueController.text = carMileValue != 0 ? carMileValue.toString() : "";
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
              labelAndValue("Maker", brands[selectedIndex]),
              SizedBox(
                height: 10,
              ),
              labelAndValue("Model", _carModel),
              SizedBox(
                height: 10,
              ),
              labelAndValue("Year", selectedYear.toString()),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _popupFormKey,
                child: Column(
                  children: [
                    carInfoBoxes(
                        "Give your vehicle a Name (optional)", nameController),
                    SizedBox(
                      height: 10,
                    ),
                    carInfoBoxes("KWH per mile", valueController,
                        "e.g. 2022 Tesla Model 3 has 0.25 kwh per mile"),
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
                  if (_popupFormKey.currentState!.validate()) {
                    setState(() {
                      isLevel = 0;
                      addVehicles();
                    });
                    saveAddedVehicle();
                    Navigator.of(context).pop();
                    showSnackBar(context, "Vehicle Added.");
                  }
                },
                child: Text("Submit"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLevel > 0 && !isOther) {
      var model = brands[selectedIndex];
      carModels = models.where((element) => element['Maker'] == model).toList();
      _carModel = _carModel.length == 0 ? carModels[0]['Model'] : _carModel;
      yearArr =
          carModels.where((element) => element['Model'] == _carModel).toList();
    }
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
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
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(text: "Add your ", style: headTexts),
                      TextSpan(
                          text: "Vehicle!",
                          style: TextStyle(
                              color: Colors.blue.shade800, fontSize: 24))
                    ]))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ImageView360(
                  key: UniqueKey(),
                  imageList: imageList,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Select your Maker"),
                    Container(
                      height: 80,
                      width: 200,
                      decoration: BoxDecoration(color: Colors.black45),
                      child: Swiper(
                        controller: scrollController,
                        viewportFraction: 0.5,
                        itemCount: brands.length,
                        scrollDirection: Axis.vertical,
                        outer: true,
                        itemHeight: 10,
                        index: selectedIndex,
                        onIndexChanged: (int Index) {
                          selectedIndex = Index;
                          _carModel = '';
                          isLevel = 0;
                          selectedYear = 0;
                          isOther = false;
                          isMiles = true;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                brands[index],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (isLevel > 0 && !isOther) selectModel(carModels),
                const SizedBox(
                  height: 20,
                ),
                if (isLevel > 1 && !isOther) selectYear(carModels),
                const SizedBox(
                  height: 20,
                ),
                if (isOther || (!isMiles && isLevel >= 2)) showCustomForm(),
                if (isError) showError(),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        // option 'other' should always be last, so when user selects that option this condition will be true.
                        if (selectedIndex == brands.length - 1) {
                          if (isLevel == 2) {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLevel = 0;
                                addOtherVehicle();
                                isOther = false;
                              });
                              saveAddedVehicle();
                            }
                          } else {
                            setState(() {
                              isLevel = 2;
                              isOther = true;
                            });
                          }
                        } else {
                          if (isLevel < 2) {
                            setState(() {
                              isLevel++;
                            });
                          } else {
                            // show car model
                            if (selectedYear == 0) {
                              setState(() {
                                isError = true;
                                errorMsg = 'Please select the year.';
                              });
                            } else {
                              bool hasMile = checkCarMileValue();
                              // see if isMiles already false
                              /* if (!isMiles) {
                                if (_formKey.currentState!.validate()) {
                                  carMileValue =
                                      double.parse(valueController.text);

                                  setState(() {
                                    hasMile = true;
                                    isMiles = true;
                                  });
                                }
                              }
                              if (hasMile) { */

                              openDialog(context);
                              //saveAddedVehicle();
                              //} else {
                              setState(() {
                                isMiles = false;
                              });
                            }
                            //}
                          }
                        }
                      },
                      child:
                          isLevel == 2 || isOther ? Text("Add") : Text("Next")),
                ),
                SizedBox(
                  height: 20,
                ),
                /* addedVehicleWidget(
                    addedVehicles: addedVehicles, function: saveAddedVehicle), */
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class addedVehicleWidget extends StatefulWidget {
  final Map<String, dynamic> addedVehicles;
  final Function function;
  const addedVehicleWidget(
      {Key? key, required this.addedVehicles, required this.function})
      : super(key: key);

  @override
  State<addedVehicleWidget> createState() => _addedVehicleWidgetState();
}

class _addedVehicleWidgetState extends State<addedVehicleWidget> {
  final _formKey = GlobalKey<FormState>();

  // all fields controller
  TextEditingController accelerateController = TextEditingController();
  TextEditingController speedController = TextEditingController();
  TextEditingController rangeController = TextEditingController();
  TextEditingController efficientController = TextEditingController();
  TextEditingController fastChargeController = TextEditingController();

  void removeItem(key) {
    setState(() {});
    widget.addedVehicles.remove(key);
    widget.function();
  }

  Future editItem(context, key) {
    accelerateController.text = widget.addedVehicles[key]!["Acceleration"];
    speedController.text = widget.addedVehicles[key]!["TopSpeed"];
    rangeController.text = widget.addedVehicles[key]!["Driving Range"];
    efficientController.text = widget.addedVehicles[key]!["Efficiency"];
    fastChargeController.text = widget.addedVehicles[key]!["FastCharge"];

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
              labelAndValue("Maker", widget.addedVehicles[key]!['Maker']),
              SizedBox(
                height: 10,
              ),
              labelAndValue("Model", widget.addedVehicles[key]!['Model']),
              SizedBox(
                height: 10,
              ),
              labelAndValue("Year", widget.addedVehicles[key]!['Year']),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
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
                      widget.addedVehicles[key]!['Acceleration'] =
                          accelerateController.text;
                      widget.addedVehicles[key]!['TopSpeed'] =
                          speedController.text;
                      widget.addedVehicles[key]!['Driving Range'] =
                          rangeController.text;
                      widget.addedVehicles[key]!['Efficiency'] =
                          efficientController.text;
                      widget.addedVehicles[key]!['FastCharge'] =
                          fastChargeController.text;
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
                child: Text("Cancel"),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget insertItem(key) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.addedVehicles[key]!['Maker']),
            Text(widget.addedVehicles[key]!['Model']),
            Text(widget.addedVehicles[key]!['Year']),
            Row(
              children: [
                InkWell(
                  child: Icon(Icons.edit),
                  onTap: () => {editItem(context, key)},
                ),
                InkWell(
                  child: Icon(Icons.delete),
                  onTap: () =>
                      {removeItem(key), showSnackBar(context, "Item Deleted.")},
                )
              ],
            )
          ],
        ),
        Divider(
          height: 10,
          thickness: 1,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Added Vehicles",
          style: headTexts,
        ),
        Divider(
          color: Colors.blue.shade800,
          height: 20,
          thickness: 3,
        ),
        if (widget.addedVehicles.length == 0)
          const Text("You do not have any vehicle added right now."),
        if (widget.addedVehicles.length != 0)
          Column(
            children: [
              for (var elem in widget.addedVehicles.keys) insertItem(elem)
            ],
          )
      ],
    );
  }
}
