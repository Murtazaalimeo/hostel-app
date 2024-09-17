
import 'package:f_container/onrent/authentication%20onrent/login_signup/login_onrent.dart';
import 'package:f_container/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreenOnrent extends StatefulWidget {

  const ForgotPasswordScreenOnrent({super.key});

  @override
  State<ForgotPasswordScreenOnrent> createState() => _ForgotPasswordScreenOnrentState();
}

class _ForgotPasswordScreenOnrentState extends State<ForgotPasswordScreenOnrent> {
  final emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  User? firebaseuser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Recover Password'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: w,
          height: h,
          child: Column(
            children: [
              Container(
                width: w,
                height: h*0.3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/img/signup1.jpg'))),
                child: Column(
                  children: [
                    SizedBox(height: h*0.16,),
                    CircleAvatar(
                      radius: 51,
                      backgroundImage: AssetImage('assets/img/profile2.png'),
                      backgroundColor: Colors.white,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: w,
                margin: const EdgeInsets.only(left: 20, top: 25),
                child: const Text('Recover Password', style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),),
              ),
              SizedBox(height: 20),
              Form(
                key: _formkey,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2)
                        )
                      ]
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'please enter email';
                      } else {
                        return null;
                      }
                    },
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined, color: Color.fromRGBO(46, 90, 136, 1),),
                        hintText: 'Enter email...',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1
                            )
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                child: Container(
                  width: w*0.40,
                  height: h*0.09,
                  decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/img/signup.jpg'
                          )
                      )
                  ),
                  child: Center(
                    child: isLoading // Show circular progress indicator if loading
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      'Send Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  if(_formkey.currentState!.validate()){
                    setState(() {
                      isLoading = true;
                    });
                    _auth.sendPasswordResetEmail(
                        email: emailcontroller.text.toString()).then((value) => {
                      showAlertDialog( context,'Recover Password ',
                        'Check the email sent to you',),
                    setState(() {
                    isLoading = false;
                    }),
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreenOnrent(),))
                    }).onError((error, stackTrace) => {
                  setState(() {
                  isLoading = false;
                  }),
                      showAlertDialog(context, "Error", error.toString())
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
void showAlertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
}
