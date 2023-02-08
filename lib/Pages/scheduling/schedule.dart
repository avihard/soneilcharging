import 'package:flutter/material.dart';
import 'package:soneilcharging/Pages/scheduling/addVehicle.dart';
import 'package:soneilcharging/Pages/scheduling/calculator.dart';

import '../../helpers/constant.dart';
import '../../helpers/utils.dart';
import '../configuration/priceSetupWidget.dart';
import 'departure.dart';
import 'optimizeCharge.dart';

class scheduleWidget extends StatefulWidget {
  const scheduleWidget({Key? key}) : super(key: key);

  @override
  State<scheduleWidget> createState() => _scheduleWidgetState();
}

class _scheduleWidgetState extends State<scheduleWidget>
    with AutomaticKeepAliveClientMixin<scheduleWidget> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "Set your times!",
            style: headerText,
          ),
          timeSectionWidget(),
          priceChargingWidget(),
        ],
      ),
    ));
  }
}

class timeSectionWidget extends StatelessWidget {
  const timeSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Schedule Charging",
                    style: smallTexts,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 16.0,
                  )
                ],
              ),
            ),
          ),
          onTap: () => {
            Navigator.of(context)
                .push(createRouteAnim(const departureWidget())),
          },
        ),
        InkWell(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price Setup",
                    style: smallTexts,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 16.0,
                  )
                ],
              ),
            ),
          ),
          onTap: () => {
            Navigator.of(context)
                .push(createRouteAnim(const PriceSetupWidget())),
          },
        ),
        InkWell(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add your vehicle",
                    style: smallTexts,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 16.0,
                  )
                ],
              ),
            ),
          ),
          onTap: () => {
            Navigator.of(context).push(createRouteAnim(const addVehicle())),
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class priceChargingWidget extends StatefulWidget {
  const priceChargingWidget({Key? key}) : super(key: key);

  @override
  State<priceChargingWidget> createState() => _priceChargingWidgetState();
}

class _priceChargingWidgetState extends State<priceChargingWidget> {
  dynamic colorVarBox1 = Colors.black;
  dynamic colorVarBox2 = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Charging!",
          style: headerText,
        ),
        SizedBox(
          height: 20,
        ),
        Wrap(
          spacing: 20.0,
          children: [
            InkWell(
              onTap: () => {
                Navigator.of(context)
                    .push(createRouteAnimDown(const chargePathWidget())),
              },
              onTapDown: (val) => {
                setState(
                  () => colorVarBox1 = Colors.grey,
                )
              },
              onTapUp: (val) => {
                setState(
                  () => colorVarBox1 = Colors.black,
                )
              },
              child: Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(color: colorVarBox1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(Icons.paste_outlined),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Charging Plan",
                        style: smallTexts,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              child: Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(color: colorVarBox2),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(Icons.calculate),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Charging Calculator",
                        style: smallTexts,
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () => {
                Navigator.of(context)
                    .push(createRouteAnim(const calculateWidget())),
              },
              onTapDown: (val) => {
                setState(
                  () => colorVarBox2 = Colors.grey,
                )
              },
              onTapUp: (val) => {
                setState(
                  () => colorVarBox2 = Colors.black,
                )
              },
            ),
          ],
        )
      ],
    );
  }
}
