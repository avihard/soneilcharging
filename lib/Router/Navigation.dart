import 'package:flutter/material.dart';
import '../index.dart';
import '../Authorization/login.dart';

// pages to route to

// utilities
import '../helpers/utils.dart';

// this code create menu bar
class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(context),
            Divider(
              height: 10,
              color: Colors.blue.shade800,
            ),
            buildMenuItems(context),
          ],
        )),
      );
}

Widget buildHeader(BuildContext context) => Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Image.asset('assets/images/companyLogo.png'),
    );

Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          hoverColor: Colors.green,
          focusColor: Colors.green,
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const indexWidget()));
          },
        ),
        /* ListTile(
          hoverColor: Colors.green,
          focusColor: Colors.green,
          leading: const Icon(Icons.contact_page),
          title: const Text('Contact Us'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const indexWidget()));
          },
        ), */
        ListTile(
          hoverColor: Colors.green,
          focusColor: Colors.green,
          leading: const Icon(Icons.settings),
          title: const Text('Logout'),
          onTap: () {
            setLoginStatus(false);
            Navigator.of(context).popUntil((route) => false);
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
          },
        ),
      ],
    ));
