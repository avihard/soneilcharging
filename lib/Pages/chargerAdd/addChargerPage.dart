import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../helpers/constant.dart';
import '../../helpers/utils.dart';
import '../../index.dart';
import '../../serivces/globalVars.dart';

// singleton service
globalVars _myService = globalVars();

class addChargerPageWidget extends StatefulWidget {
  const addChargerPageWidget({Key? key}) : super(key: key);

  @override
  State<addChargerPageWidget> createState() => _addChargerPageWidgetState();
}

class _addChargerPageWidgetState extends State<addChargerPageWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                      text: "Charger!",
                      style:
                          TextStyle(color: Colors.blue.shade800, fontSize: 24))
                ]))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: chargerFormWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class chargerFormWidget extends StatefulWidget {
  const chargerFormWidget({Key? key}) : super(key: key);

  @override
  State<chargerFormWidget> createState() => _chargerFormWidgetState();
}

class _chargerFormWidgetState extends State<chargerFormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                hintText: 'Serial ID',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    // this should call API to save charger values!!!
                    _myService.setIsCharger(true);
                    Navigator.of(context).pop();
                    Navigator.of(context).push(createRoute(indexWidget()));
                  }
                },
                child: const Text("ADD"))
          ],
        ));
  }
}
