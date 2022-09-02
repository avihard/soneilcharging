import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class settingWidget extends StatefulWidget {
  const settingWidget({Key? key}) : super(key: key);

  @override
  State<settingWidget> createState() => _settingWidgetState();
}

class _settingWidgetState extends State<settingWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Text("heyy"),
    );
  }
}
