import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);


  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
    
              child: Column(
                children: <Widget>[
                  Container(
                    margin:const EdgeInsets.only(
                      top: 70
                    ),
    
                child:
                  Text(
                      "Welcome to",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color( 0xFF006666)
    
                    ),
                  ),
      ),
                  Text("MediCure+",
                  style: TextStyle(
                  fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      color: Color( 0xFF006666)
      ),
                  ),
    
    
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal:90
              ),
              child: Center(
                child: Image.asset("assets/welcome.png"),
              ),
            ),
            Container(
              child: Container(
                margin: EdgeInsets.all(18),
                padding: EdgeInsets.all(14),
                width: double.infinity,
                decoration: BoxDecoration(
    
                  color:  Color( 0xFF006666),
                  borderRadius: BorderRadius.circular(50)
                ),
             child:Center(
                child: Text(
                  "Get Started",
                      style:TextStyle(
                       color: Colors.white
    
                ),
                ),
             ),
              ),
            ),
    
            Text('Already have an account?'),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Sign In',),
            ),
    
    
          ],
        ),
    
      ),
    );
  }
}