import 'package:flutter/material.dart';

// functional widgets
import 'Pages/home.dart';
import 'Pages/profile.dart';
import 'functions/chargerData.dart';

// welcome page
import 'Authorization/login.dart';

// navigation
import 'Router/Navigation.dart';

class indexWidget extends StatefulWidget {
  const indexWidget({Key? key}) : super(key: key);

  @override
  State<indexWidget> createState() => _indexWidgetState();
}

class _indexWidgetState extends State<indexWidget> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          'Dashboard',
          style: TextStyle(fontStyle: FontStyle.normal, fontSize: 32),
        ),
      ), */
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          pageChanged(index);
        },
        children: [
          HomeWidget(
            onButtonPressed: () => pageController.animateToPage(
              1,
              duration: Duration(milliseconds: 300),
              curve: Curves.linear,
            ),
          ),
          myProfileWidget()
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: (() => {}),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), */ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
