import 'package:digitect_task/auth/verify_user_email.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  static const routeName = "/SignUp";
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController phoneNumber = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[500],
          elevation: 0.0,
          title: const Align(
              alignment: Alignment.center,
              child: Text(
                "Sign up",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "NotoSans",
                    fontWeight: FontWeight.w700),
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "It's time to set your account!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "NotoSans",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      key: const ValueKey("Phone number"),
                      controller: phoneNumber,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(30)),
                        prefix: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '+966',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ) {
                          return "please enter a valid number";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      'We\'ll send you an OTP ',
                      style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w800,
                          fontFamily: "NotoSans",
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      'The phone number you provide will be sent a 6 digit code, used to verify your phone number',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          fontFamily: "NotoSans",
                          color: Colors.black,
                          overflow: TextOverflow.fade),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: MaterialButton(
                      elevation: 5,
                      color: Colors.amber[500],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text("SIGN UP"),
                      onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context){return VerifyUserEmail(phoneNumberField: phoneNumber.text,);}));
                      },
                    ),
                  )
                ],
              )),
        ));
  }
}
