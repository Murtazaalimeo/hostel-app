import 'package:f_container/onrent/authentication%20onrent/login_signup/login_onrent.dart';
import 'package:f_container/onrent/authentication%20onrent/login_signup/signup_wth_phone.dart';
import 'package:f_container/onrent/onrent_screens/get_user_detail_screen.dart';
import 'package:f_container/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreenOnrent extends StatefulWidget {

  const SignupScreenOnrent({super.key});
  @override
  State<SignupScreenOnrent> createState() => _SignupScreenOnrentState();
}
class _SignupScreenOnrentState extends State<SignupScreenOnrent> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  bool _agreedToTerms = false;
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    // Regular expressions to check for alphabetic and numeric characters
    RegExp alphabeticRegex = RegExp(r'[a-zA-Z]');
    RegExp numericRegex = RegExp(r'[0-9]');

    if (!alphabeticRegex.hasMatch(value) || !numericRegex.hasMatch(value)) {
      return 'Password must contain both alphabetic and numeric characters';
    }

    return null;
  }
  bool _passwordVisible = false;
  var confirmpasserror = '';
  List images = [
    "g.png",
    "t.png",
    "f.png"
  ];
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Account'),
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                       Text('Continue with Email', style: TextStyle(
                          fontSize: 18,
                           color: Colors.grey[500],
                         //fontStyle: FontStyle.italic
                        )),
                     ],
                   ),
                 ),
                const SizedBox(height: 15),
                Container(
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
                        hintText: 'Enter Email',
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
                const SizedBox(height: 10),
                Container(
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
                    validator: validatePassword,
                    controller: passwordcontroller,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_passwordVisible, // Set the obscureText value based on _passwordVisible
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password, color: Color.fromRGBO(46, 90, 136, 1),),
                      hintText: 'Create new Password',
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
                      ),
                      //Add the eye button to toggle password visibility
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                // const SizedBox(height: 10),
                // Container(
                //   margin: const EdgeInsets.only(left: 20, right: 20),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30),
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //             blurRadius: 10,
                //             spreadRadius: 7,
                //             offset: const Offset(1, 1),
                //             color: Colors.grey.withOpacity(0.2)
                //         )
                //       ]
                //   ),
                //   child: TextFormField(
                //     validator: (value) {
                //       if(value!.isEmpty){
                //         return 'please re-enter password';
                //       } else {
                //         return null;
                //       }
                //     },
                //     controller: confirmpasswordcontroller,
                //     keyboardType: TextInputType.visiblePassword,
                //     obscureText: !_passwordVisible,
                //     decoration: InputDecoration(
                //         prefixIcon: const Icon(Icons.password_outlined),
                //         prefixIconColor: Colors.deepOrangeAccent,
                //         hintText: 'Confirm Password',
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(30),
                //             borderSide: const BorderSide(
                //               color: Colors.white,
                //               width: 1,
                //             )
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(30),
                //           borderSide: const BorderSide(
                //               color: Colors.white,
                //               width: 1
                //           ),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(30),
                //             borderSide: const BorderSide(
                //                 color: Colors.white,
                //                 width: 1
                //             )
                //         ),
                //       // suffixIcon: IconButton(
                //       //   onPressed: () {
                //       //     setState(() {
                //       //       _passwordVisible1 = !_passwordVisible1;
                //       //     });
                //       //   },
                //       //   icon: Icon(_passwordVisible1 ? Icons.visibility : Icons.visibility_off),
                //       //   color: Colors.grey,
                //       // ),
                //     ),
                //   ),
                // ),
                Container(
                    width: w,
                    margin: const EdgeInsets.only(left: 35, top: 4),
                    child: Text(confirmpasserror, style: TextStyle(color: Colors.red),)),
                // Container(
                //   margin: const EdgeInsets.only(left: 20),
                //   child: Row(
                //     children: [
                //       Checkbox(value: _passwordVisible, onChanged: (value){
                //         setState(() {
                //           _passwordVisible = value!;
                //         });
                //       } ,),
                //       Text('Show Password')
                //     ],
                //   ),
                // ),
                // Container(
                //   margin: const EdgeInsets.only(left: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Checkbox(
                //         value: _agreedToTerms,
                //         onChanged: (value) {
                //           setState(() {
                //             _agreedToTerms = value!;
                //           });
                //         },
                //       ),
                //       Text('I agree to the Terms and Conditions'),
                //     ],
                //   ),
                // ),
               // const SizedBox(height: 10),
                InkWell(
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          width: w*0.4,
                          height: h*0.08,
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
                              'Signup',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  onTap: () {
                    final email = emailcontroller.text;
                    final password = passwordcontroller.text;

                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        isLoading = true; // Show CircularProgressIndicator
                      });
                        _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password).then((value) {
                          setState(() {
                            isLoading = false; // Show CircularProgressIndicator
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Account created successfully!'),
                            ),
                          );
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => GetUserDetailScreenOnrent(),));

                        }).onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              content: Text(error.toString()),
                            ),
                          );
                          setState(() {
                            isLoading = false; // Show CircularProgressIndicator
                          });
                        });
                        setState(() {
                          confirmpasserror = '';
                        });

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
                          Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreenOnrent(),));
                        },
                        child: const Text('Signin', style: TextStyle(
                            color: Color.fromRGBO(46, 90, 136, 1),
                            fontSize: 16
                        ),))
                  ],
                ),
                const SizedBox(height: 10),
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
                      child: Text('Countinue with Phone Number', style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signupwithphone(),));
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

