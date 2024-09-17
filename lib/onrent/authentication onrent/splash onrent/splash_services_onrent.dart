import 'dart:async';
import 'package:f_container/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../onrent_screens/home.dart';
import '../../onrent_screens/intro.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SplashServicesOnrent {
  void issignin(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
        Timer.periodic(Duration(seconds: 3), (timer) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage(),));
        });

  }else {
      Timer.periodic(Duration(seconds: 3), (timer) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnboardingScreen()));
       });
    }
  }
}
