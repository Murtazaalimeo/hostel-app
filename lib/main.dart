
import 'package:f_container/onrent/onrent_screens/Onrent_home.dart';
import 'package:f_container/onrent/onrent_screens/get_hostel_details_onrent.dart';
import 'package:f_container/onrent/onrent_screens/my_account_onrent.dart';
import 'package:f_container/onrent/onrent_screens/my_ads_onrent.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';
import 'onrent/authentication onrent/splash onrent/Splash_screen_onrent.dart';
import 'onrent/onrent_screens/daynightmoodscreen.dart';
import 'onrent/onrent_screens/get_user_detail_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PersistentShoppingCart().init();
  Stripe.publishableKey = 'pk_test_51OghVGJKM7tbgReCU1dHECP2ci2UgORwGgFKMkD9iDYMug9zHYk077RwdLI7BZghMNFeCuKgKCBzpdZ1VCJaDn4U00foNz7GFN';

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int currentindex = 0;


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        //brightness: Brightness.dark,
        textTheme: const TextTheme(
          headlineMedium: TextStyle( color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              wordSpacing: 1.0
          ),
          displayLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
          displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black45),
          displayMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blueAccent),
          headlineSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          // titleMedium: TextStyle(color: Colors.black, fontSize: 8),

        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      themeMode: ThemeMode.light,
      home: SplashScreenOnrent(),
      routes: {
        '/homescreen': (context) => HomeScreenOnrent(),
        '/userdetailscreen': (context) => GetUserDetailScreenOnrent(),
        '/daynightmodescreen': (context) => DayNightModeScreen(),
      },
    );
  }
}
