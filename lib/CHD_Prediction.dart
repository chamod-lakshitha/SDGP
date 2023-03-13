import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Result.dart';

class CHD_Prediction extends StatefulWidget {
  const CHD_Prediction({Key? key}) : super(key: key);

  @override
  State<CHD_Prediction> createState() => _CHD_PredictionState();
}

class _CHD_PredictionState extends State<CHD_Prediction> {
  String? userID;
  double? _sex,
      _age,
      _cigsPerDay,
      _bpMeds,
      _prevalentHyp,
      _totChol,
      _sys_BP,
      _dia_BP,
      _BMI,
      _heartRate,
      _glucose;
  String _predictedResult = "1";

  final _formKey = GlobalKey<FormState>();

  Future<bool> sendRiskFactorDetails() async {
    try {
      print("came");
      var response = await Dio().post(
          "http://" +
              (dotenv.env['IPV_4'])! +
              ":8000/api/chd_prediction/predict",
          data: {
            "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
            "userID": userID,
            "sex": _sex,
            "age": _age,
            "cigsPerDay": _cigsPerDay,
            "bpMeds": _bpMeds,
            "prevalentHyp": _prevalentHyp,
            "totChol": _totChol,
            "sys_BP": _sys_BP,
            "dia_BP": _dia_BP,
            "BMI": _BMI,
            "heartRate": _heartRate,
            "glucose": _glucose
          });
      if (response.data["success"]) {
        _predictedResult = response.data["value"];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void setUserID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey("userID")) {
      userID = pref.getInt("userID").toString();
    }
  }

  @override
  void initState() {
    super.initState();
    setUserID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Predict CHD Risk",
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
            margin: const EdgeInsets.only(top: 15),
            height: 25,
            child: Center(
              child: Text(
                "Insert your information",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 52.5),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 400,
            width: double.infinity - 20,
            color: Colors.blueGrey[50],
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Gender",
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          hint: const Text("Select gender"),
                          items: [
                            DropdownMenuItem(
                              value: "1",
                              child: Row(
                                children: const [
                                  Icon(Icons.male),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Male",
                                  ),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: "-1",
                              child: Row(
                                children: const [
                                  Icon(Icons.female),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Female",
                                  ),
                                ],
                              ),
                            ),
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          icon: const Icon(Icons.arrow_drop_down),
                          validator: (sex) {
                            if (_sex == null) {
                              return "Please select gender";
                            }
                          },
                          onChanged: (sex) {
                            _sex = (sex as String?) == "1" ? 1 : 0;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Age",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chevron_right_sharp),
                      ),
                      validator: (age) {
                        try {
                          if (age == null || age.isEmpty) {
                            return "Age can not be empty";
                          } else {
                            double ageInDouble = double.parse(age);
                            if (!(ageInDouble > 0 && ageInDouble < 100)) {
                              return "Invalid value for age";
                            }
                          }
                        } catch (e) {
                          return "Age should be a number";
                        }
                      },
                      onChanged: (age) {
                        _age = double.tryParse(age);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Cigarets_per_day",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chevron_right_sharp),
                      ),
                      validator: (cigsPerDay) {
                        try {
                          if (cigsPerDay == null || cigsPerDay.isEmpty) {
                            return "Cigarets_per_day can not be empty";
                          } else {
                            double cigsPerDayInDouble =
                                double.parse(cigsPerDay);
                            if (!(cigsPerDayInDouble >= 0)) {
                              return "Invalid value for Cigarets_per_day";
                            }
                          }
                        } catch (e) {
                          return "Cigarets_per_day should be a number";
                        }
                      },
                      onChanged: (cigsPerDay) {
                        _cigsPerDay = double.tryParse(cigsPerDay);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "BP_Meds",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chevron_right_sharp),
                      ),
                      validator: (bpMeds) {
                        try {
                          if (bpMeds == null || bpMeds.isEmpty) {
                            return "BP_Meds can not be empty";
                          } else {
                            double bpMedsInDouble = double.parse(bpMeds);
                            if (!(bpMedsInDouble == 0 || bpMedsInDouble == 1)) {
                              return "Invalid value for BP_Meds, should be either 0 or 1";
                            }
                          }
                        } catch (e) {
                          return "BP_Meds should be a number";
                        }
                      },
                      onChanged: (bpMeds) {
                        _bpMeds = double.tryParse(bpMeds);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Prevalent_Hyp",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chevron_right_sharp),
                      ),
                      validator: (prevalentHyp) {
                        try {
                          if (prevalentHyp == null || prevalentHyp.isEmpty) {
                            return "BP_Meds can not be empty";
                          } else {
                            double prevalentHypInDouble =
                                double.parse(prevalentHyp);
                            if (!(prevalentHypInDouble == 0 ||
                                prevalentHypInDouble == 1)) {
                              return "Invalid value for BP_Meds, should be either 0 or 1";
                            }
                          }
                        } catch (e) {
                          return "BP_Meds should be a number";
                        }
                      },
                      onChanged: (prevalentHyp) {
                        _prevalentHyp = double.tryParse(prevalentHyp);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Total_Cholesterol",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chevron_right_sharp),
                      ),
                      validator: (totChol) {
                        try {
                          if (totChol == null || totChol.isEmpty) {
                            return "Total_Cholesterol can not be empty";
                          } else {
                            double totCholInDouble = double.parse(totChol);
                            if (!(totCholInDouble >= 90 &&
                                totCholInDouble <= 700)) {
                              return "Invalid value for Total_Cholesterol";
                            }
                          }
                        } catch (e) {
                          return "Total_Cholesterol should be a number";
                        }
                      },
                      onChanged: (totChol) {
                        _totChol = double.tryParse(totChol);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Systolic Blood Pressure",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chevron_right_sharp),
                      ),
                      validator: (sys_BP) {
                        try {
                          if (sys_BP == null || sys_BP.isEmpty) {
                            return "Systolic Blood Pressure can not be empty";
                          } else {
                            double sys_BPInDouble = double.parse(sys_BP);
                            if (sys_BPInDouble < 0) {
                              return "Invalid value for Systolic Blood Pressure";
                            }
                          }
                        } catch (e) {
                          return "Systolic Blood Pressure should be a number";
                        }
                      },
                      onChanged: (sys_BP) {
                        _sys_BP = double.tryParse(sys_BP);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Diastolic Blood Pressure",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chevron_right_sharp),
                      ),
                      validator: (dia_BP) {
                        try {
                          if (dia_BP == null || dia_BP.isEmpty) {
                            return "Diastolic Blood Pressure can not be empty";
                          } else {
                            double dia_BPInDouble = double.parse(dia_BP);
                            if (dia_BPInDouble < 0) {
                              return "Invalid value for Diastolic Blood Pressure";
                            }
                          }
                        } catch (e) {
                          return "Diastolic Blood Pressure should be a number";
                        }
                      },
                      onChanged: (dia_BP) {
                        _dia_BP = double.tryParse(dia_BP);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "BMI",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chevron_right_sharp),
                      ),
                      validator: (BMI) {
                        try {
                          if (BMI == null || BMI.isEmpty) {
                            return "BMI can not be empty";
                          } else {
                            double BMIInDouble = double.parse(BMI);
                            if (BMIInDouble < 0 || BMIInDouble >= 90) {
                              return "Invalid value for BMI";
                            }
                          }
                        } catch (e) {
                          return "BMI should be a number";
                        }
                      },
                      onChanged: (BMI) {
                        _BMI = double.tryParse(BMI);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "heartRate",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chevron_right_sharp),
                      ),
                      validator: (heartRate) {
                        try {
                          if (heartRate == null || heartRate.isEmpty) {
                            return "heartRate can not be empty";
                          } else {
                            double heartRateInDouble = double.parse(heartRate);
                            if (heartRateInDouble < 0 ||
                                heartRateInDouble >= 200) {
                              return "Invalid value for heartRate";
                            }
                          }
                        } catch (e) {
                          return "heartRate should be a number";
                        }
                      },
                      onChanged: (heartRate) {
                        _heartRate = double.tryParse(heartRate);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Glucose",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chevron_right_sharp),
                      ),
                      validator: (glucose) {
                        try {
                          if (glucose == null || glucose.isEmpty) {
                            return "Glucose level can not be empty";
                          } else {
                            double glucoseInDouble = double.parse(glucose);
                            if (glucoseInDouble < 0 || glucoseInDouble >= 500) {
                              return "Invalid value for Glucose level";
                            }
                          }
                        } catch (e) {
                          return "Glucose level should be a number";
                        }
                      },
                      onChanged: (glucose) {
                        _glucose = double.tryParse(glucose);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                EasyLoading.show(status: 'predicting...');
                if (await sendRiskFactorDetails()) {
                  print(_predictedResult);
                  // Future.delayed(const Duration(seconds: 2, microseconds: 500),
                  //     () {

                  // });
                  Future.delayed(const Duration(seconds: 1, microseconds: 500),
                      () {
                    EasyLoading.dismiss();
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    PageTransition(
                      child: Result(prediction: _predictedResult),
                      type: PageTransitionType.leftToRight,
                    ),
                  );
                } else {
                  print("hello");
                  EasyLoading.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Error occurred. Try again in few minutes"),
                    ),
                  );
                }
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: 475, left: 10),
              height: 50,
              width: MediaQuery.of(context).size.width - 20,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 93, 93, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Predict Risk",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
