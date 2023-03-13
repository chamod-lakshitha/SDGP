import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'Home.dart';

class Result extends StatelessWidget {
  Result({Key? key, required this.prediction}) : super(key: key);

  final String prediction;
  List tips = [
    "Eat a healthy, balanced diets",
    "Be more physically active all time",
    "Keep to a healthy weight",
    "Give up smoking",
    "Reduce your alcohol consumption",
    "Keep your blood pressure under control",
    "Take any prescribed medicine",
    "Keep your diabetes under control"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Test Results",
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 93, 93, 1),
        elevation: 2.5,
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
            width: double.infinity - 20,
            height: 50,
            color: prediction == "0" ? Colors.green : Colors.red,
            child: Center(
              child: Text(
                prediction == "0" ? "You are safe." : "You are at a CHD risk.",
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(top: 97.5, right: 10, left: 10),
            width: double.infinity - 20,
            height: 60,
            child: Text(
              prediction == "0"
                  ? "Congratulations! You are safe. Adhere to the following recommendations to maintain your healthiness."
                  : "Consult a doctor immediately. Adhere to the following recommendations.",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  height: 1.25,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(top: 157.5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: double.infinity - 20,
            height: 350,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
            ),
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Card(
                        child: ListTile(
                          leading: const Icon(Icons.recommend),
                          title: Text(
                            tips[index],
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 15.5,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          iconColor: const Color.fromRGBO(0, 93, 93, 1),
                          tileColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: Home(
                    selectedIndex: 0,
                  ),
                  type: PageTransitionType.fade,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 530, left: 10),
              color: const Color.fromRGBO(0, 93, 93, 1),
              height: 50,
              width: MediaQuery.of(context).size.width - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Go to DashBoard\t\t\t",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
