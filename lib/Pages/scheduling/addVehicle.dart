import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../helpers/constant.dart';
import '../../helpers/carModels.dart';

class addVehicle extends StatefulWidget {
  const addVehicle({Key? key}) : super(key: key);

  @override
  State<addVehicle> createState() => _addVehicleState();
}

class _addVehicleState extends State<addVehicle> {
  List<ImageProvider> imageList = <ImageProvider>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList.add(AssetImage('assets/images/tesla_car1.png'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: Swiper(
                          viewportFraction: 0.5,
                          itemCount: brands.length,
                          scrollDirection: Axis.vertical,
                          outer: true,
                          itemHeight: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(brands[index]),
                              ),
                            );
                          }),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
