
import 'package:f_container/onrent/authentication%20onrent/splash%20onrent/splash_services_onrent.dart';
import 'package:flutter/material.dart';

class SplashScreenOnrent extends StatefulWidget {


  @override
  State<SplashScreenOnrent> createState() => _SplashScreenOnrentState();
}

class _SplashScreenOnrentState extends State<SplashScreenOnrent> {
  SplashServicesOnrent splashscreenonrent = SplashServicesOnrent();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashscreenonrent.issignin(context);
  }
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
          Color(0xff6495ED),
          Color(0xffcf6cc9),
          //Color(0xffee609c),
          //Color(0xffee609c),

              ])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('Welcome to the', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),)
            ),
            SizedBox(height: 7),
            Container(
                child: Text('ONRENT HOSTEL RENTAL APP', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25
                ),)
            ),
           ]
        ),
      ),
    );
  }
}
