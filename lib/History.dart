import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List history = [];

  Widget renderBody() {
    if (history.isEmpty) {
      return Center(
        child: Text(
          "Currently no previous history available.",
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity - 20,
        height: 560,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
        ),
        child: ListView.builder(
          itemCount: history.length,
          itemBuilder: (BuildContext context, int index) {
            List historySet = history[index].entries.toList();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Card(
                    child: ListTile(
                      leading: Text(
                        (index + 1).toString() + ".",
                        style: TextStyle(fontSize: 17.5),
                      ),
                      minLeadingWidth: 15,
                      title: Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        "Date - " +
                            (historySet[1].value).substring(
                                0, (historySet[1].value).indexOf("T")),
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 15.5,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      trailing: Text(
                        historySet[14].value == "1"
                            ? "Positive Risk"
                            : "Negative Risk",
                        style: TextStyle(
                          color: historySet[14].value == "0"
                              ? const Color.fromRGBO(0, 93, 93, 1)
                              : Colors.red,
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
      );
    }
  }

  Future<bool> makeAPICall() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      print("came");
      var response = await Dio().post(
          (dotenv.env['server'])! + "api/chd_prediction/history",
          data: {"userID": (pref.getInt("userID")).toString()});
      if (response.data["success"]) {
        history = response.data["result"];
        return true;
      } else {
        print("unsuccessfull");
        return false;
      }
    } catch (e) {
      print("unsuccessfull");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Predict History",
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 93, 93, 1),
        elevation: 2.5,
      ),
      body: FutureBuilder(
          future: makeAPICall(),
          builder: (BuildContext, snapshot) {
            if (snapshot.data == null) {
              EasyLoading.show(status: 'loading...');
              return const SizedBox();
            } else {
              EasyLoading.dismiss();
              return renderBody();
            }
          }),
    );
  }
}
