import 'package:flutter/material.dart';
import 'package:soneilcharging/Pages/scheduling/addVehicle.dart';

import '../../helpers/constant.dart';
import 'departure.dart';

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
          timeSectionWidget()
        ],
      ),
    ));
  }
}

class timeSectionWidget extends StatelessWidget {
  const timeSectionWidget({Key? key}) : super(key: key);

  // this function brings the new page from the right side.
  Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

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
                    "Departure Time",
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
            Navigator.of(context).push(createRoute(const departureWidget())),
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
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 16.0,
                  )
                ],
              ),
            ),
          ),
          onTap: () => {
            Navigator.of(context).push(createRoute(const addVehicle())),
          },
        ),
      ],
    );
  }
}
