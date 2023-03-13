import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';
import 'Register.dart';
import 'Welcome.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? _email, _password;
  String prompt = "";

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<bool> _onWillPop() async {
    return (await Navigator.pushReplacement(
      context,
      PageTransition(
        child: const Welcome(),
        type: PageTransitionType.theme,
      ),
    ));
  }

  setUserId(userID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("userID", userID);
    print(pref.getInt("userID"));
  }

  Future<bool> sendLoginDetails() async {
    try {
      print("came");
      var response = await Dio().post(
          (dotenv.env['server'])! + "api/user/login",
          data: {"email": _email, "password": _password});
      if (response.data["success"]) {
        setUserId(response.data["userID"]);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Login to MediCure+",
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
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 35),
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/login.png"),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 270),
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blueGrey[75],
                border: const Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Colors.black26,
                  ),
                ),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email)) {
                            return "Please enter an valid email";
                          }
                          return null;
                        },
                        onChanged: (email) {
                          _email = email;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.password),
                        ),
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        onChanged: (password) {
                          _password = password;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity - 10,
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot password ? ",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: Color.fromRGBO(0, 93, 93, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2 + 10),
              child: Center(
                child: Text(
                  prompt,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    bool flag = await sendLoginDetails();
                    if (flag) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: Home(selectedIndex: 0),
                          type: PageTransitionType.leftToRight,
                        ),
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invalid Email or Password."),
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 455),
                  color: const Color.fromRGBO(0, 93, 93, 1),
                  height: 50,
                  width: MediaQuery.of(context).size.width - 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Login",
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
                        Icons.app_registration_rounded,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 550),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: const Register(),
                        type: PageTransitionType.leftToRight,
                      ),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " Register.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(0, 93, 93, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
