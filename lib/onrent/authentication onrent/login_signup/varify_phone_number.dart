import 'package:f_container/onrent/authentication%20onrent/login_signup/signup_wth_phone.dart';
import 'package:f_container/onrent/onrent_screens/get_user_detail_screen.dart';
import 'package:f_container/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPReceivedScreen extends StatefulWidget {
  final String phoneNumber; // Phone number for which OTP was sent
  final String verificationID;
  OTPReceivedScreen({required this.phoneNumber, required this.verificationID});

  @override
  State<OTPReceivedScreen> createState() => _OTPReceivedScreenState();
}

class _OTPReceivedScreenState extends State<OTPReceivedScreen> {
  final _auth = FirebaseAuth.instance;
  String otpCode = '';
  bool isLoading = false;
  final otpcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: w,
              height: h*0.3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/img/signup.png'))),
              child: Column(
                children: [
                  SizedBox(height: h*0.16,),
                  CircleAvatar(
                    radius: 51,
                    backgroundImage: AssetImage('assets/img/profile.png',),
                    backgroundColor: Colors.grey.shade300,
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'OTP Verification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'An OTP has been sent to ${widget.phoneNumber}. Please enter the code below to verify your phone number.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 30),
            // OTPInputField(), // Custom widget for OTP input
            // SizedBox(height: 20),
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
                    return 'please enter OTP Code';
                  } else {
                    return null;
                  }
                },
                controller: otpcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password, color: Colors.deepOrangeAccent,),
                    hintText: 'Enter OTP Code...',
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
            SizedBox(height: 20),
            InkWell(
              child: Container(
                width: w*0.35,
                height: h*0.07,
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/img/loginbtn.png'
                        )
                    )
                ),
                child: Center(
                  child: isLoading // Show circular progress indicator if loading
                      ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                    'Verify',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () async {
                setState(() {
                  isLoading = true; // Start loading
                });
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationID,
                    smsCode: otpcontroller.text.toString());
                try {
                  setState(() {
                    isLoading = false; // Start loading
                  });
                  await _auth.signInWithCredential(credential);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account created successfully!'),
                    ),
                  );
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetUserDetailScreenOnrent(),));
                } catch (e) {
                  setState(() {
                    isLoading = false; // Start loading
                  });
                  utils().toastMessage(e.toString());
                }

              },
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Resend OTP logic here
              },
              child: Text('Resend OTP'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Signupwithphone(),));
              },
              child: Text('Wrong Number?'),
            ),
          ],
        ),
      ),
    );
  }
}

class OTPInputField extends StatefulWidget {
  @override
  _OTPInputFieldState createState() => _OTPInputFieldState();
}

class _OTPInputFieldState extends State<OTPInputField> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 6; i++) {
      TextEditingController controller = TextEditingController();
      FocusNode focusNode = FocusNode();

      controller.addListener(() {
        if (controller.text.length == 1) {
          if (i < 5) {
            FocusScope.of(context).requestFocus(focusNodes[i + 1]);
          } else {
            // Last box, perform verification or any other action
          }
        }
      });

      controllers.add(controller);
      focusNodes.add(focusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 6; i++)
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controllers[i],
              focusNode: focusNodes[i],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                counterText: '', // Hide character count
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}

