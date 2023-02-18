import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> checkForLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getInt("userID"));
    return pref.containsKey("userID");
  }

  @override
  void initState() {
    super.initState();
    // Timer(
    //   const Duration(seconds: 5),
    //   () async {
    //     bool flag = await checkForLogin();
    //     if (!flag) {
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => const Welcome()),
    //       );

    //     } else {
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => Home(selectedIndex: 0)),
    //       );
    //     }
    //   },
    // );
    Timer(Duration(seconds: 5), ()async { 
      Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Welcome()),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2 - 100),
                    width: 225,
                    height: 150,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/logo.png"),
                          fit: BoxFit.cover),
                      border: Border.all(color: Colors.black12),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3 - 150),
                  width: 30,
                  height: 30,
                  child: const CircularProgressIndicator(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
