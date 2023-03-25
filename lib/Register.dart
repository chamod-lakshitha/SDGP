import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'Login.dart';
import 'Welcome.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? _name, _email, _password;
  bool alreadyRegistered = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

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

  Future<bool> sendRegistrationDetails() async {
    try {
      var response = await Dio().post(
          (dotenv.env['server'])! + "api/user/register",
          data: {"name": _name, "email": _email, "password": _password});
      if (response.data["success"]) {
        if (response.data["alreadyRegistered"]) {
          alreadyRegistered = true;
        } else {
          alreadyRegistered = false;
        }
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
            "Register to MediCure+",
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
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
              width: double.infinity,
              height: 320,
              decoration: BoxDecoration(
                color: Colors.blueGrey[75],
                border: const Border(
                  bottom: BorderSide(width: 2, color: Colors.black26),
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
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Full Name",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (name) {
                          RegExp exp =
                              new RegExp(r"[^a-z ]", caseSensitive: false);
                          if (name == null || name.isEmpty) {
                            return "Please enter your full name";
                          } else if (exp.allMatches(name).length != 0) {
                            return "Please enter your full name correctly";
                          }
                          return null;
                        },
                        onChanged: (name) {
                          _name = name;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
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
                            return "Please enter your password.";
                          }else if (password.length <= 5) {
                            return "Password is too short. Use a strong password";
                          } else if (isAlpha(password) || isNumeric(password)) {
                            return "Password should be a combination of numbers and letters";
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
                      TextFormField(
                        controller: _cPasswordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Confirm password",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.password),
                        ),
                        validator: (cPassword) {
                          if (cPassword == null || cPassword.isEmpty) {
                            return "Please enter your password again.";
                          }
                          if (_cPasswordController.text !=
                              _passwordController.text) {
                            return "Password do not match.";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  bool flag = await sendRegistrationDetails();
                  if (flag) {
                    if (alreadyRegistered) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Email is already registered with MediCure+. Please login.")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Registered successful. Please login."),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Error occurred. Try again in few minutes"),
                      ),
                    );
                  }
                }
              },
              child: Container(
                margin: const EdgeInsets.only(
                  top: 375,
                  left: 10,
                ),
                height: 50,
                color: const Color.fromRGBO(0, 93, 93, 1),
                width: MediaQuery.of(context).size.width - 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Register",
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
            Container(
              margin: const EdgeInsets.only(top: 445),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "_______________ or Sign up from ______________",
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 17.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                              image: AssetImage("assets/fb.png"),
                              fit: BoxFit.contain),
                          border: Border.all(color: Colors.black26),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                              image: AssetImage("assets/apple.png"),
                              fit: BoxFit.cover),
                          border: Border.all(color: Colors.black26),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                              image: AssetImage("assets/google.png"),
                              fit: BoxFit.contain),
                          border: Border.all(color: Colors.black26),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                              image: AssetImage("assets/twitter.png"),
                              fit: BoxFit.contain),
                          border: Border.all(color: Colors.black26),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 500),
              height: 50,
              width: double.infinity - 50,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2, color: Colors.black26),
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
                        child: const Login(),
                        type: PageTransitionType.leftToRight,
                      ),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " Login.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 93, 93, 1),
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
