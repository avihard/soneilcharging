import 'package:soneilcharging/Authorization/signup.dart';
import 'package:soneilcharging/index.dart';
import 'package:flutter/material.dart';

// utility imports
import '../helpers/utils.dart';

import '../index.dart';
import 'signup.dart';
import 'forgotpassword.dart';

class Login extends StatelessWidget {
  static const routeName = '/login-screen';
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

  bool isValidEmail(value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
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
              return 'Please enter some text.';
            } else if (hintTitle == "Email" && !isValidEmail(value)) {
              return 'Please enter valid email.';
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
            Container(
              height: 400,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 45),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          userInput(emailController, 'Email',
                              TextInputType.emailAddress),
                          userInput(passwordController, 'Password',
                              TextInputType.visiblePassword),
                        ],
                      ),
                    ),
                    Container(
                      height: 55,
                      // for an exact replicate, remove the padding.
                      // pour une réplique exact, enlever le padding.
                      padding:
                          const EdgeInsets.only(top: 5, left: 70, right: 70),
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
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: InkWell(
                        onTap: () => {
                          Navigator.of(context)
                              .push(createRoute(ForgotPasswordWidget()))
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.blue.shade800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "OR",
              style: TextStyle(
                  color: Colors.blue.shade800, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Wrap(
              children: [
                const Text("Do not have an account yet? "),
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
            )
          ],
        ),
      ),
    ));
  }
}
