import 'package:f_container/onrent/authentication%20onrent/login_signup/signup_onrent.dart';
import 'package:f_container/onrent/authentication%20onrent/login_signup/varify_phone_number.dart';
import 'package:f_container/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_onrent.dart';

class Signupwithphone extends StatefulWidget {

  const Signupwithphone({super.key});

  @override
  State<Signupwithphone> createState() => _SignupwithphoneState();
}

class _SignupwithphoneState extends State<Signupwithphone> {
  final phonenumbercontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  User? firebaseuser = FirebaseAuth.instance.currentUser;
  List<Map<String, String>> countryCodes = [
    {"code": "+92", "name": "+92"},
  ];
  String selectedCountryCode = "+92";
  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        //.backgroundColor:Color.fromRGBO(46, 90, 136, 1),
        title: Text('Create new Account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                        backgroundImage: AssetImage('assets/img/profile2.png',),
                        backgroundColor: Colors.grey.shade300,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: w,
                  margin: const EdgeInsets.only(left: 20, top: 25),
                  child: const Text('Create new account', style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: h*0.005,),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Continue with Phone Number', style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[500],
                        //fontStyle: FontStyle.italic
                      )),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.only(left: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Enter Number as (+923xxx...)',
                      style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic,
                      color: Colors.grey),),
                    ],
                  ),
                ),
                SizedBox(height: 3),
                Form(
                  key: _formkey,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
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
                      controller: phonenumbercontroller,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(15), // Limit to 10 digits
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter phone number';
                        } else if (value.length < 10) {
                          return 'Invalid phone number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          phoneNumber = value;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: 'Enter phone number...',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic
                          ),
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
                //SizedBox(height: 20),
                // Form(
                //   key: _formkey,
                //   child: Container(
                //     margin: EdgeInsets.only(left: 20, right: 20),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(30),
                //         color: Colors.white,
                //         boxShadow: [
                //           BoxShadow(
                //               blurRadius: 10,
                //               spreadRadius: 7,
                //               offset: const Offset(1, 1),
                //               color: Colors.grey.withOpacity(0.2)
                //           )
                //         ]
                //     ),
                //     child: IntlPhoneField(
                //       dropdownIconPosition: IconPosition.trailing,
                //
                //       disableLengthCheck: true,
                //       disableAutoFillHints: true,
                //       initialCountryCode: 'Pakistan',
                //       controller: phonenumbercontroller,
                //      invalidNumberMessage: 'Invalid Number try again',
                //       keyboardType: TextInputType.phone,
                //       decoration: InputDecoration(
                //           hintText: 'e.g 3xx-xxxxxxx',
                //           hintStyle: const TextStyle(
                //               color: Colors.grey,
                //               fontStyle: FontStyle.italic
                //           ),
                //           border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(30),
                //               borderSide: const BorderSide(
                //                 color: Colors.white,
                //                 width: 1,
                //               )
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(30),
                //             borderSide: const BorderSide(
                //                 color: Colors.white,
                //                 width: 1
                //             ),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(30),
                //               borderSide: const BorderSide(
                //                   color: Colors.white,
                //                   width: 1
                //               )
                //           )
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),
                InkWell(
                  child: Container(
                    width: w*0.35,
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                   if (_formkey.currentState!.validate()) {
                      setState(() {
                        isLoading = true; // Start loading
                      });

                      try {
                        await _auth.verifyPhoneNumber(
                          phoneNumber: phonenumbercontroller.text,
                          verificationCompleted: (_) {},
                          verificationFailed: (e) {
                            utils().toastMessage(e.toString());
                            setState(() {
                              isLoading = false; // Stop loading on error
                            });
                          },
                          codeSent: (String verificationID, int? token) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPReceivedScreen(
                                  phoneNumber: phonenumbercontroller.text,
                                  verificationID: verificationID,
                                ),
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (e) {
                            utils().toastMessage(e.toString());
                            setState(() {
                              isLoading = false; // Stop loading on error
                            });
                          },
                        );
                      } catch (e) {
                        utils().toastMessage(e.toString());
                        setState(() {
                          isLoading = false; // Stop loading on error
                        });
                      }
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?", style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                    ),),
                    TextButton(
                        onPressed: (){
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreenOnrent(),));
                        },
                        child: const Text('Signin', style: TextStyle(
                            color: Color.fromRGBO(46, 90, 136, 1),
                            fontSize: 16
                        ),))
                  ],
                ),
                SizedBox(height: 10),
                InkWell(
                  child: Container(
                    width: w*0.8,
                    height: h*0.06,
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
                    child: Center(
                      child: Text('Countinue with Email', style: TextStyle(
                          fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),),
                    ),
                  ),
                  onTap: (){

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupScreenOnrent(),));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
