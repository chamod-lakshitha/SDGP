import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Login extends StatefulWidget {
    const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Padding(
        padding: const EdgeInsets.all(27),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w100,
                    color: Colors.teal,
                  ),
                ),
    
                Image.asset("assets/login.png"),
               
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration:  InputDecoration(
                    labelText: "Enter email",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment:  MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, child: const Text(
                      "Forget Password?"
                    ))
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Color.fromARGB(255, 0, 100, 93),
                  ),
                  child: MaterialButton(
                    onPressed: (){},
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: [
                    Text(
                      "Are you new to medicure+?",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                      ),
    
                    ),
                    TextButton(onPressed: (){}, child: const Text(
                        "Register"
                    ),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}