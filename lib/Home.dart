import 'package:flutter/material.dart';
import 'package:sdgp/CHD_Prediction.dart';

import 'BMI_Calc.dart';

class Home extends StatefulWidget {
  final int selectedIndex;
  Home({super.key, this.selectedIndex = 0});

  @override
  State<Home> createState() => _HomeState(selectedIndex);
}

class _HomeState extends State<Home> {
  int selectedIndex;
  _HomeState(this.selectedIndex);

  List<Widget> screenList = const [CHD_Prediction(), BMI_Calc()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: IndexedStack(children: screenList, index: selectedIndex),
      body: screenList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: "Predict"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate), label: "BMI Calculator"),
        ],
        backgroundColor: Color.fromRGBO(0, 93, 93, 1),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        showUnselectedLabels: false,
      ),
    );
  }
}
