
import 'package:f_container/modules/usermodel.dart';
import 'package:f_container/onrent/onrent_screens/helpandsuppourt.dart';
import 'package:f_container/onrent/onrent_screens/profileupdatescreenonrent.dart';
import 'package:f_container/onrent/onrent_screens/showuserimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../modules/firebasehelper.dart';
import '../../utils/utils.dart';
import '../authentication onrent/login_signup/login_onrent.dart';
import 'accountsettingonrent.dart';

class MyAccountScreenOnrent extends StatefulWidget {
  const MyAccountScreenOnrent({Key? key}) : super(key: key);

  @override
  State<MyAccountScreenOnrent> createState() => MyAccountScreenOnrentState();
}

class MyAccountScreenOnrentState extends State<MyAccountScreenOnrent> {
  final _auth = FirebaseAuth.instance;
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  UserModel? currentUserModel;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserModel();
  }

  Future<void> fetchCurrentUserModel() async {
    if (firebaseUser != null) {
      currentUserModel = await FirebaseHelper1.getUserModelById(firebaseUser!.uid);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor:Color.fromRGBO(46, 90, 136, 1),
        title: Text('My Account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: w,
                height: h * 0.30,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/img/signup1.jpg'),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: h * 0.15),
                    InkWell(
                      onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowUserImage(currentUser: currentUserModel,),));},
                      child: CircleAvatar(
                        backgroundImage: currentUserModel?.pimgurl != null
                            ? NetworkImage(currentUserModel!.pimgurl!)
                            : null,
                        child: currentUserModel?.pimgurl == null
                            ? Text(
                          'Add Photo',
                          style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                        )
                            : null,
                        radius: 55,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3),
              Column(
                children: [
                  Text(
                    currentUserModel?.fname ?? 'Creat Account',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 5),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('View & Update Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('manage your profile'),
                trailing: Icon(Icons.arrow_forward_ios),
                minLeadingWidth: 10,
                onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileUpdateOnRent(),));}
              ),
              SizedBox(height: 5),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Setting', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('privacy and manage account'),
                trailing: Icon(Icons.arrow_forward_ios),
                minLeadingWidth: 10,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingOnrent(),));
                },
              ),
              SizedBox(height: 5),
              ListTile(
                leading: Icon(Icons.help_center),
                title: Text('Help & Support', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('Help center and legal terms'),
                trailing: Icon(Icons.arrow_forward_ios),
                minLeadingWidth: 10,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HelpSupportScreen(),));
                },
              ),
              SizedBox(height: 5),
              ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                trailing: Icon(Icons.arrow_forward_ios),
                subtitle: Text('logout from the app'),
                minLeadingWidth: 10,
                onTap: () {
                  _auth.signOut().then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sign out Successfully'),
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreenOnrent()),
                    );
                  }).onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                        content: Text("Error ${error.toString()}"),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
