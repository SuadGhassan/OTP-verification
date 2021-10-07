import 'dart:async';

import 'package:digitect_task/auth/verify_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyUserEmail extends StatefulWidget {
  static const routeName = "/VerifyUserEmail";
  final String? phoneNumberField;
  const VerifyUserEmail({required this.phoneNumberField});

  @override
  _VerifyUserEmailState createState() => _VerifyUserEmailState();
}

class _VerifyUserEmailState extends State<VerifyUserEmail> {
  final TextEditingController textEditingController =
      TextEditingController(text: "");
  StreamController<ErrorAnimationType>? errorController;
  String verificationCode = "";// this the code come from SMS message 
  final _formKey = GlobalKey<FormState>();
  CountDownController _controller = CountDownController();
  int _timer = 60;
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  
      void _verifyPhoneNumber() async {
        print(widget.phoneNumberField);
        // // final isValid = _formKey.currentState.validate();
        // FocusScope.of(context).unfocus();
        // if (isValid) {
        //   _formKey.currentState!.save();

          try {
            _auth.verifyPhoneNumber(
                phoneNumber: "+966${widget.phoneNumberField}",
                //this the last step where the user recieve the code and enter it correctly
                verificationCompleted: (PhoneAuthCredential credential) async {
                  _auth.signInWithCredential(credential).then((value) => {
                        if (value.user != null)
                          {Navigator.pushNamed(context, VerifyResult.routeName)}
                      });
                },
                
                verificationFailed: (FirebaseAuthException e) async {
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("$e.message")));
                },
                // this method will send the code to the user device
                codeSent: (verificationId, resendingToken) async {
                  setState(() {
                    verificationCode=verificationId;
                  });
                },
                //here when the code is timout, this will resend the code
                codeAutoRetrievalTimeout: (verificationId) async {setState(() {
                   verificationCode=verificationId;
                  });},
                  timeout: const Duration(seconds: 60));
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("$e.message"),
            ));
          }
          print(widget.phoneNumberField);
        }
         
      
    
    
  

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    _verifyPhoneNumber();
    super.initState();
  }

  @override
  void dispose() {
    // textEditingController.dispose();
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.03,
            iconTheme: const IconThemeData(color: Colors.black),
            automaticallyImplyLeading: true,
            flexibleSpace: const Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 15),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Verify",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "NotoSans",
                      ))),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                 Text("We've sent a verification code to +966${widget.phoneNumberField} ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: "NotoSans",
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 10),
                      child: PinCodeTextField(
                        appContext: context,
                       

                        length: 6,
                        
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "I'm from validator";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(60),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeFillColor: Colors.amber[500],
                          activeColor: Colors.amber[500],
                          inactiveColor: Colors.amber[500],
                          inactiveFillColor: Colors.amber[500],
                          selectedFillColor: Colors.amber[500],
                          selectedColor: Colors.amber[500],
                        ),
                        cursorColor: Colors.white,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.phone,
                       
                        // pin this the code enter by the user and will send it to firebase with the verificationCode form SMS message
                        onCompleted: (pin) async { 
                          try {
                            await _auth
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationCode,
                                        smsCode: pin))
                                .then((value) {
                              if (value.user != null) {
                                Navigator.pushNamed(
                                    context, VerifyResult.routeName);
                              }
                            });
                            
                          } catch (e) {
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(content: Text("$e.message")));
                          }
                        },
                      
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            verificationCode = value;
                          });
                        },
                       
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        CircularCountDownTimer(
                          width: 50,
                          height: 50,
                          duration: _timer,
                          ringColor: Colors.white,
                          fillColor: Colors.amber.withOpacity(0.7),
                          controller: _controller,
                          backgroundColor: Colors.white54,
                          strokeWidth: 10.0,
                          strokeCap: StrokeCap.round,
                          isTimerTextShown: true,
                          // isReverse: true,
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Didn't receive otp yet?",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "NotoSans",
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                            onTap: _verifyPhoneNumber,
                            child: const Text("Resend",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "NotoSans",
                                    color: Colors.grey,
                                    decoration: TextDecoration.underline))),
                      ],
                    )
                  ],
                ),
                
              ],
            ),
          ),
        ));
  }
}
