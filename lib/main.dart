import 'package:firebase_core/firebase_core.dart';
import 'package:digitect_task/auth/signup.dart';
import 'package:digitect_task/auth/verify_result.dart';
import 'package:digitect_task/auth/verify_user_email.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapShat) {
          if (snapShat.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(strokeWidth :15),
                ),
              ),
            );
          } else if (snapShat.hasError) {
            return const MaterialApp(
                home: Scaffold(
                    body: Center(
                        child: Text(" Error has occured, please try again!",
                            style: TextStyle(
                                fontSize: 18, fontFamily: "NotoSans")))));
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                backgroundColor: Colors.white,
                primarySwatch: Colors.grey,
              ),
              home:  const SignUp(),
              routes: {
                SignUp.routeName: (ctx) => const SignUp(),
                // VerifyUserEmail.routeName: (ctx) => const VerifyUserEmail(),
                VerifyResult.routeName: (ctx) => const VerifyResult(),
              },
            );
          }
        });
  }
}
