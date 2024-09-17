
import 'package:f_container/onrent/authentication%20onrent/login_signup/forgot_email_password_onrent.dart';
import 'package:f_container/onrent/authentication%20onrent/login_signup/signup_onrent.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../onrent_screens/home.dart';
import 'signup_wth_phone.dart';


class LoginScreenOnrent extends StatefulWidget {

  const LoginScreenOnrent({super.key});



  @override
  State<LoginScreenOnrent> createState() => _LoginScreenOnrentState();
}

class _LoginScreenOnrentState extends State<LoginScreenOnrent> {
  User? firebaseuser = FirebaseAuth.instance.currentUser;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Signin to your account'),
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
                  margin: const EdgeInsets.only(left: 20, top: 25),
                  width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Welcome to ONRENT', style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),),
                  SizedBox(height: h*0.005,),
                  Text('Signin to your account', style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[500]
                  ),
                  )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: Offset(1, 1),
                        color: Colors.grey.withOpacity(0.2)
                      )
                    ]
                  ),
                  child: TextFormField(
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'please enter email';
                      }else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined, color: Color.fromRGBO(46, 90, 136, 1),),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1
                        )
                      )
                    ),
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
                            offset: Offset(1, 1),
                            color: Colors.grey.withOpacity(0.2)
                        )
                      ]
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'please enter password';
                      } else {
                        return null;
                      }
                    },
                    controller: passwordcontroller,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_outlined, color: Color.fromRGBO(46, 90, 136, 1),),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 1
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: 1
                            )
                        ),
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
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: w*0.9,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      child: Text('Forgot your Password?', style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500]
                      )),
                      onTap: (){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ForgotPasswordScreenOnrent(),));
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  child: Container(
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
                      child: loading // Show circular progress indicator if loading
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        'Sign in',
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
                        loading = true;
                      });
                      _auth.signInWithEmailAndPassword(
                          email: emailcontroller.text.toString(),
                          password: passwordcontroller.text.toString()).then((value) => {
                      setState(() {
                      loading = false;
                      }),
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Signin Successfully'),
                          ),
                        ),
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyHomePage(),))
                      }).onError((error, stackTrace) => {
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                            content: Text(error.toString()),
                          ),
                        ),
                      setState(() {
                      loading = false;
                      })
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Don't have an account?", style: TextStyle(
                     color: Colors.grey,
                     fontSize: 16
                   ),),
                   TextButton(
                       onPressed: (){
                         Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => SignupScreenOnrent(),));
                       },
                       child: Text('Çreate', style: TextStyle(
                         color: Color.fromRGBO(46, 90, 136, 1),
                         fontSize: 16
                       ),))
                 ],
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Signupwithphone(),));
                      }, child:Text("sign in with Phone number", style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16
                  ),)
                  )
                ],
              )
             ]
          ),
        ),
      ),
      ),
    );
  }
}
