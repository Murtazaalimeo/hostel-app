import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'daynightmoodscreen.dart';
import 'notificationsettingscreen.dart';

class AccountSettingOnrent extends StatefulWidget {
  const AccountSettingOnrent({Key? key}) : super(key: key);

  @override
  State<AccountSettingOnrent> createState() => _AccountSettingOnrentState();
}

class _AccountSettingOnrentState extends State<AccountSettingOnrent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 20,),

              ListTile(
                leading: Icon(Icons.nightlight_outlined),
                title: Text('Night Mode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('enable/disable night mode'),
                trailing: Icon(Icons.arrow_forward_ios),
                minLeadingWidth: 10,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DayNightModeScreen()));
                },
              ),
              SizedBox(height: 10,),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notification Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('enable/disable app notifications'),
                trailing: Icon(Icons.arrow_forward_ios),
                minLeadingWidth: 10,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationSettingsScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
