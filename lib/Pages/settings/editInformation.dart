import 'package:flutter/material.dart';

import '../../helpers/constant.dart';
import '../../helpers/utils.dart';

class editPersonalInfo extends StatefulWidget {
  const editPersonalInfo({Key? key}) : super(key: key);

  @override
  State<editPersonalInfo> createState() => _editPersonalInfoState();
}

class _editPersonalInfoState extends State<editPersonalInfo> {
  bool isResetPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onTap: () => {Navigator.pop(context)},
              ),
            ),
            Flexible(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Edit Information",
                      textAlign: TextAlign.center,
                      style: headTexts,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      alignment: Alignment.center,
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Username",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: "dev1ceee",
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Email",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: "vyasjeet13@gmail.com",
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey, // NEW
                                    elevation: 10,
                                    fixedSize: Size(200, 50),
                                    visualDensity: VisualDensity.comfortable),
                                onPressed: () => {
                                  setState(
                                    () => {isResetPass = !isResetPass},
                                  )
                                },
                                child: const Text("Reset Password"),
                              ),
                            ),
                            if (isResetPass) resetPassWidget(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: ElevatedButton(
                                      onPressed: () => {
                                            // API call here to save the data
                                            showSnackBar(
                                                context, "Profile Updated"),
                                            Navigator.of(context).pop()
                                          },
                                      child: const Text("Save")),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent, // NEW
                                          visualDensity:
                                              VisualDensity.comfortable),
                                      onPressed: () =>
                                          {Navigator.of(context).pop()},
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class resetPassWidget extends StatefulWidget {
  const resetPassWidget({Key? key}) : super(key: key);

  @override
  State<resetPassWidget> createState() => _resetPassWidgetState();
}

class _resetPassWidgetState extends State<resetPassWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      // Define how long the animation should take.
      duration: const Duration(milliseconds: 900),
      // Provide an optional curve to make the animation feel smoother.
      curve: Curves.fastOutSlowIn,
      child: Form(
        child: Column(
          children: [
            const Text("Current Password:"),
            const Text("New Password:"),
            const Text("Confirm new Password:")
          ],
        ),
      ),
    );
  }
}
