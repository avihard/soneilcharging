import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:soneilcharging/Authorization/forgotpassword.dart';

import '../../helpers/constant.dart';
import '../../helpers/carModels.dart';

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

  Map<String, Map<String, dynamic>> addedVehicles = {};

  // error and errorMsg
  bool isError = false;
  String errorMsg = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList.add(AssetImage('assets/images/tesla_car1.png'));
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
          () => {selectedYear = item, isError = false, errorMsg = ''},
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

  void addVehicles() {
    String idString =
        (brands[selectedIndex] + _carModel + selectedYear.toString())
            .toLowerCase()
            .trim();

    var itemToAdd = {
      'Id': idString,
      'Maker': brands[selectedIndex],
      'Model': _carModel,
      'Year': selectedYear.toString()
    };

    addedVehicles[idString] = itemToAdd;
  }

  @override
  Widget build(BuildContext context) {
    if (isLevel > 0) {
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
                if (isLevel > 0) selectModel(carModels),
                const SizedBox(
                  height: 20,
                ),
                if (isLevel > 1) selectYear(carModels),
                const SizedBox(
                  height: 20,
                ),
                if (isError) showError(),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
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
                            setState(() {
                              addVehicles();
                            });
                          }
                        }
                      },
                      child: isLevel == 2 ? Text("Add") : Text("Next")),
                ),
                SizedBox(
                  height: 20,
                ),
                addedVehicleWidget(addedVehicles: addedVehicles),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class addedVehicleWidget extends StatefulWidget {
  final Map<String, Map<String, dynamic>> addedVehicles;
  const addedVehicleWidget({Key? key, required this.addedVehicles})
      : super(key: key);

  @override
  State<addedVehicleWidget> createState() => _addedVehicleWidgetState();
}

class _addedVehicleWidgetState extends State<addedVehicleWidget> {
  void removeItem(key) {
    setState(() {
      widget.addedVehicles.remove(key);
    });
  }

  Widget insertItem(key) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(widget.addedVehicles[key]!['Maker']),
            Text(widget.addedVehicles[key]!['Model']),
            Text(widget.addedVehicles[key]!['Year']),
            InkWell(
              child: Icon(Icons.delete),
              onTap: () => {removeItem(key)},
            )
          ],
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
