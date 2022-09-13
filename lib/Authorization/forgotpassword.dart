import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// constant file
import '../helpers/utils.dart';
import '../index.dart';

FocusNode firstTextFocusNode = new FocusNode();
FocusNode secondTextFocusNode = new FocusNode();
FocusNode thirdTextFocusNode = new FocusNode();
FocusNode fourTextFocusNode = new FocusNode();

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: mainResetWidget(),
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

  late FocusNode firstFocusNode;
  late FocusNode thirdFocusNode;
  late FocusNode secondFocusNode;
  late FocusNode fourthFocusNode;

  /* bool isFirstEnable = true;
  bool isSecondEnable = false;
  bool isThirdEnable = false;
  bool isFourthEnable = false; */
/* 
  var enableTextArr = {
    "first": true,
    "second": false,
    "third": false,
    "fourth": false
  }; */

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

    /* setState(() {
      enableTextArr[id] = false;
      enableTextArr[key] = true;
    }); */
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    firstFocusNode = FocusNode();
    secondFocusNode = FocusNode();
    thirdFocusNode = FocusNode();
    fourthFocusNode = FocusNode();
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.all(15),
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
          style: TextStyle(color: Colors.black),
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
    Size _size = MediaQuery.of(context).size;
    if (isForgot == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: InkWell(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue.shade800,
                ),
                onTap: () => {Navigator.pop(context)},
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.blue.shade100),
              child: Icon(
                Icons.lock_person_sharp,
                size: 84,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: CustomPaint(
              size: Size(double.infinity, double.infinity),
              painter: forgotPainter(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child:
                        userInput(emailController, 'Email', TextInputType.text),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, // NEW
                        elevation: 10,
                        fixedSize: Size(200, 50),
                        visualDensity: VisualDensity.comfortable),
                    onPressed: (() => {
                          if (_formKey.currentState!.validate())
                            {
                              setState(
                                () => {isForgot = !isForgot},
                              )
                            }
                        }),
                    child: Text(
                      'Submit',
                      style:
                          TextStyle(fontSize: 16, color: Colors.blue.shade800),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Flexible(
            flex: 1,
            child: CustomPaint(
              size: Size(double.infinity, MediaQuery.of(context).size.height),
              painter: resetPainter(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: InkWell(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onTap: () => {Navigator.pop(context)},
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white30),
                      child: Icon(
                        Icons.reset_tv,
                        size: 84,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 60,
                      child: TextField(
                        enabled: true,
                        key: Key("first"),
                        autofocus: true,
                        controller: _fieldOne,
                        focusNode: firstFocusNode,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          counterText: '',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        onChanged: (value) {
                          if (value.length != 0) {
                            FocusScope.of(context)
                                .requestFocus(secondFocusNode);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 60,
                      child: TextField(
                        enabled: true,
                        key: Key("second"),
                        autofocus: true,
                        controller: _fieldTwo,
                        focusNode: secondFocusNode,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            counterText: '',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 20.0)),
                        onChanged: (value) {
                          setTextEdit(value, "second");
                          if (value.length == 0) {
                            FocusScope.of(context).requestFocus(firstFocusNode);
                          } else {
                            FocusScope.of(context).requestFocus(thirdFocusNode);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 60,
                      child: TextField(
                        enabled: true,
                        key: Key("third"),
                        autofocus: true,
                        controller: _fieldThree,
                        focusNode: thirdFocusNode,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            counterText: '',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 20.0)),
                        onChanged: (value) {
                          //setTextEdit(value, "third");
                          if (value.length == 0) {
                            FocusScope.of(context)
                                .requestFocus(secondFocusNode);
                          } else {
                            FocusScope.of(context)
                                .requestFocus(fourthFocusNode);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 60,
                      child: TextField(
                        enabled: true,
                        key: Key("fourth"),
                        autofocus: true,
                        controller: _fieldFour,
                        focusNode: fourthFocusNode,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            counterText: '',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 20.0)),
                        onChanged: (value) {
                          //setTextEdit(value, "fourth");
                          if (value.length == 0) {
                            FocusScope.of(context).requestFocus(thirdFocusNode);
                          } else {
                            setTextEdit(value, "fourth");
                          }
                        },
                      ),
                    ),
                    /* OtpInput(_fieldOne, true, "first", enableTextArr['first'],
                        setTextEdit, firstTextFocusNode),
                    OtpInput(
                        _fieldTwo,
                        false,
                        "second",
                        enableTextArr['second'],
                        setTextEdit,
                        secondTextFocusNode),
                    OtpInput(
                        _fieldThree,
                        false,
                        "third",
                        enableTextArr['third'],
                        setTextEdit,
                        thirdTextFocusNode),
                    OtpInput(
                        _fieldFour,
                        false,
                        "fourth",
                        enableTextArr['fourth'],
                        setTextEdit,
                        fourTextFocusNode), */
                  ],
                )
              ],
            ),
          )
        ],
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

  final FocusNode focusNode;

  const OtpInput(this.controller, this.autoFocus, this.textBoxId,
      this.isEnabled, this.setTextEdit, this.focusNode,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 60,
      child: TextField(
        enabled: isEnabled,
        key: Key(textBoxId),
        autofocus: false,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        style: TextStyle(color: Colors.black),
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
            disabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          setTextEdit(value, textBoxId);
          FocusScope.of(context).requestFocus(secondTextFocusNode);
        },
      ),
    );
  }
}
