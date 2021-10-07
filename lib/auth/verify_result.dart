import 'package:flutter/material.dart';

class VerifyResult extends StatelessWidget {
  static const routeName = "/VerifyResult";
  const VerifyResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Image.asset("assets/images/animation_500_ku3zgml3.gif"),
          const Text("Congratulations!",
              style: TextStyle(
                  fontFamily: "assets/fonts/NotoSans-Bold.ttf",
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
          const Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16, top: 5),
            child: Text(
                "you have successfully completed the sign up process! We hope you enjoy our services!",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontFamily: "assets/fonts/NotoSans-Regular.ttf"),
                textAlign: TextAlign.center),
                
          ),
          SizedBox(height:MediaQuery.of(context).size.height*0.25,),
          const Padding(
                padding:  EdgeInsets.only(bottom:20.0),
                child:  Text("Back to menu",style:TextStyle(fontFamily:"assets/fonts/NotoSans-Regular.ttf",fontSize: 12),textAlign: TextAlign.center),
              ),
        ]),
      ),
      // bottomNavigationBar: const Padding(
      //   padding:  EdgeInsets.only(bottom:20.0),
      //   child:  Text("Back to menu",style:TextStyle(fontFamily:"assets/fonts/NotoSans-Regular.ttf",fontSize: 12),textAlign: TextAlign.center),
      // ),
    );
  }
}
