import 'package:soneilcharging/Authorization/login.dart';
import 'package:flutter/material.dart';
import '../helpers/utils.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool _isObscure = true;

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType, IconData icon) {
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
            prefixIcon: Icon(
              icon,
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            CustomPaint(
              painter: linePainter(),
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.39,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Signup",
                        style: TextStyle(fontSize: 48.0),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("with", style: TextStyle(fontSize: 32.0)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Soneil",
                          style: TextStyle(
                              fontSize: 48.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontFamily: 'Rubik'))
                    ],
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  userInput(usernameController, 'Username', TextInputType.text,
                      Icons.attribution_outlined),
                  userInput(emailController, 'Email',
                      TextInputType.emailAddress, Icons.email),
                  userInput(passwordController, 'Password',
                      TextInputType.visiblePassword, Icons.password),
                ],
              ),
            ),
            Container(
              height: 55,
              width: double.infinity,
              // for an exact replicate, remove the padding.
              // pour une réplique exact, enlever le padding.
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Colors.blue.shade800,
                onPressed: () {
                  _formKey.currentState!.validate();
                  /* print(emailController);
                          print(passwordController); */
                  /* Provider.of<Auth>(context, listen: false).login(emailController.text, passwordController.text);
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SuccessfulScreen())); */
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "OR",
              style: TextStyle(
                  color: Colors.blue.shade800, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Wrap(
              children: [
                const Text(
                  "Already Registered? ",
                  style: TextStyle(color: Colors.black),
                ),
                InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    )
                  },
                  child: Text(
                    "Log in",
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
    );
  }
}
