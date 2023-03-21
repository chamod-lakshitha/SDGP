import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMI_Calc extends StatefulWidget {
  const BMI_Calc({Key? key}) : super(key: key);

  @override
  State<BMI_Calc> createState() => _BMI_CalcState();
}

class _BMI_CalcState extends State<BMI_Calc> {
  double? _height, _weight;
  double BMI = 0;
  bool calculated = false;

  final _formKey = GlobalKey<FormState>();

  Widget printLabel() {
    if (calculated) {
      return Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.only(
          top: 480,
        ),
        color: BMI < 18.5
            ? Colors.amber
            : BMI < 24.9
                ? Colors.green
                : BMI < 29.9
                    ? Colors.orange
                    : Colors.red,
        alignment: Alignment.center,
        child: Text(
          calculated ? "BMI value is : " + BMI.toStringAsFixed(2) : "",
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black54,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
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
            height: 210,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/BMI_chart.jpg"), fit: BoxFit.fill),
            ),
          ),
          Container(
            height: 160,
            width: double.infinity,
            color: Colors.blueGrey[50],
            margin: const EdgeInsets.only(top: 240),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Height in Meters",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.height),
                    ),
                    validator: (height) {
                      try {
                        double heightInDouble = double.parse(height!);
                        if (height == null || height.isEmpty) {
                          return "Please enter your height in meters";
                        } else if (heightInDouble <= 0) {
                          return "height can not be less than or equals  to zero";
                        }
                      } catch (e) {
                        return "Invalid value for height";
                      }
                    },
                    onChanged: (height) {
                      _height = double.tryParse(height);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Weight in kilogram",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.monitor_weight),
                    ),
                    validator: (weight) {
                      try {
                        double weightInDouble = double.parse(weight!);
                        if (weight == null || weight.isEmpty) {
                          return "Please enter your weight in meters";
                        } else if (weightInDouble <= 0) {
                          return "weight can not be less than or equals  to zero";
                        }
                      } catch (e) {
                        return "Invalid value for weight";
                      }
                    },
                    onChanged: (weight) {
                      _weight = double.tryParse(weight);
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                BMI = (_weight! / (_height! * _height!));
                setState(() {
                  calculated = true;
                });
              } else {
                setState(() {
                  calculated = false;
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: 415, left: 10),
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
                    "Calculate BMI",
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
          printLabel()
        ],
      ),
    );
  }
}
