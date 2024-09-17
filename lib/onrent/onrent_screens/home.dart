import 'package:f_container/onrent/onrent_screens/Onrent_home.dart';
import 'package:f_container/onrent/onrent_screens/chat/homechat.dart';
import 'package:f_container/onrent/onrent_screens/get_hostel_details_onrent.dart';
import 'package:f_container/onrent/onrent_screens/my_account_onrent.dart';
import 'package:f_container/onrent/onrent_screens/my_ads_onrent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int currentindex = 0;

  void OnTap(int index) {
    setState(() {
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List screens = [
      HomeScreenOnrent(),
      AddHostelScreenOnrent(),
      MyAdsScreenOnrent(),
      MyAccountScreenOnrent(),
      LimitedDataPage(),
    ];
    return Scaffold(
      body: screens[currentindex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentindex,
          onTap: OnTap,
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF2E5A88),
          unselectedItemColor: Colors.blue.withOpacity(0.5),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'Add', icon: Icon(Icons.add)),
            BottomNavigationBarItem(
                label: 'My Ads', icon: Icon(Icons.health_and_safety_rounded)),
            BottomNavigationBarItem(label: 'Account', icon: Icon(Icons.person)),

            BottomNavigationBarItem(label: 'Chats', icon: Icon(Icons.mark_unread_chat_alt)),
          ]
      ),
    );
  }
}