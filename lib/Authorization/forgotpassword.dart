import 'package:flutter/material.dart';

// constant file
import '../helpers/utils.dart';
import '../index.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 50, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/companyLogo.png'),
              const mainResetWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class mainResetWidget extends StatefulWidget {
  const mainResetWidget({Key? key}) : super(key: key);

  @override
  State<mainResetWidget> createState() => _mainResetWidgetState();
}

class _mainResetWidgetState extends State<mainResetWidget> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  var enableTextArr = {
    "first": true,
    "second": false,
    "third": false,
    "fourth": false
  };

  void setTextEdit(String value, String id) {
    String key = "first";
    bool isEnable = true;
    switch (id) {
      case "first":
        key = value.length == 0 ? "first" : "second";
        break;
      case "second":
        key = value.length == 0 ? "first" : "third";
        break;
      case "third":
        key = value.length == 0 ? "second" : "fourth";
        break;
      case "fourth":
        key = value.length == 0 ? "third" : "fourth";
        String userStrOTP = _fieldOne.text +
            _fieldTwo.text +
            _fieldThree.text +
            _fieldFour.text;
        int userOTP = int.parse(userStrOTP);
        if (userOTP == 1234) {
          Navigator.pop(context, true);
          Navigator.of(context).push(createRoute(indexWidget()));
        }
        break;
      default:
    }

    setState(() {
      enableTextArr[id] = false;
      enableTextArr[key] = true;
    });
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextFormField(
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: const TextStyle(
                fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  bool isForgot = true;
  @override
  Widget build(BuildContext context) {
    if (isForgot == true) {
      return Container(
        height: 400,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Forgot Password?",
                style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              SizedBox(height: 15),
              Form(
                key: _formKey,
                child: userInput(emailController, 'Email', TextInputType.text),
              ),
              ElevatedButton(
                  onPressed: (() => {
                        if (_formKey.currentState!.validate())
                          {
                            setState(
                              () => {isForgot = !isForgot},
                            )
                          }
                      }),
                  child: const Text("Submit"))
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 400,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              Text(
                "Reset Password",
                style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                OtpInput(_fieldOne, true, "first", enableTextArr['first'],
                    setTextEdit),
                OtpInput(_fieldTwo, false, "second", enableTextArr['second'],
                    setTextEdit),
                OtpInput(_fieldThree, false, "third", enableTextArr['third'],
                    setTextEdit),
                OtpInput(_fieldFour, false, "fourth", enableTextArr['fourth'],
                    setTextEdit),
              ]),
              SizedBox(
                height: 15,
              ),
              /* ElevatedButton(
                  onPressed: (() =>
                      {print(_fieldFour.text), print(_fieldTwo.text)}),
                  child: const Text("Submit")) */
            ],
          ),
        ),
      );
    }
  }
}

// Create an input widget that takes only one digit
class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  final String textBoxId;
  final bool? isEnabled;
  final void Function(String, String) setTextEdit;

  const OtpInput(this.controller, this.autoFocus, this.textBoxId,
      this.isEnabled, this.setTextEdit,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        enabled: isEnabled,
        key: Key(textBoxId),
        autofocus: isEnabled!,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          setTextEdit(value, textBoxId);
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }
}
