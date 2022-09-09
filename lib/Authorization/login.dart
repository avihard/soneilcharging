import 'package:intl/intl.dart';
import 'package:soneilcharging/Authorization/signup.dart';
import 'package:soneilcharging/Pages/settings.dart';
import 'package:soneilcharging/index.dart';
import 'package:flutter/material.dart';

// utility imports
import '../helpers/utils.dart';

import '../index.dart';
import 'signup.dart';
import 'forgotpassword.dart';

class Login extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool _isObscure = true;

  Widget login(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(onPressed: () {}, child: Text('Login')),
        ],
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 15),
        child: TextFormField(
          controller: userInput,
          obscureText: hintTitle == "Password" ? _isObscure : false,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          style: TextStyle(color: Colors.black),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text.';
            } else if (hintTitle == "Email" && !isValidEmail(value)) {
              return 'Please enter valid email.';
            }
            return null;
          },
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade800),
            ),
            errorBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            prefixIcon: hintTitle == "Email"
                ? Icon(Icons.email, color: Colors.blue.shade800)
                : Icon(
                    Icons.password,
                    color: Colors.blue.shade800,
                  ),
            suffixIcon: hintTitle == "Password"
                ? IconButton(
                    color: Colors.blue.shade800,
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )
                : null,
            hintText: hintTitle,
            hintStyle: const TextStyle(
                fontSize: 18, color: Colors.grey, fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.zero,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Image.asset('assets/images/companyLogo.png'),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    'Welcome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        userInput(emailController, 'Email',
                            TextInputType.emailAddress),
                        userInput(passwordController, 'Password',
                            TextInputType.visiblePassword),
                        InkWell(
                          onTap: () => {
                            Navigator.of(context)
                                .push(createRoute(ForgotPasswordWidget()))
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blue.shade800),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 55,
                    // for an exact replicate, remove the padding.
                    // pour une réplique exact, enlever le padding.
                    padding: const EdgeInsets.only(top: 5, left: 70, right: 70),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: Colors.blue.shade800,
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            emailController.text == "admin@gmail.com" &&
                            passwordController.text == "admin") {
                          setLoginStatus(true);
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .push(createRoute(indexWidget()));
                        }
                        /* Provider.of<Auth>(context, listen: false).login(emailController.text, passwordController.text);
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SuccessfulScreen())); */
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.blue.shade800, Colors.blue]),
                          borderRadius: BorderRadius.all(Radius.circular(60.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 58.0,
                              minHeight:
                                  36.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'LOGIN',
                                textAlign: TextAlign.center,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.arrow_right_alt_outlined),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                ],
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                const Text(
                  "Don't have an account yet? ",
                  style: TextStyle(color: Colors.black),
                ),
                InkWell(
                  onTap: () => {
                    Navigator.pop(context, true),
                    Navigator.of(context).push(createRoute(Signup()))
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Flexible(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: CurvePainter(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
