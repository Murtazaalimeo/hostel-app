// // ... (Previous code remains unchanged)
//
// class _SignupwithphoneState extends State<Signupwithphone> {
//   // ... (Previous code remains unchanged)
//
//   bool isLoading = false; // Add this line to track loading state
//
//   @override
//   Widget build(BuildContext context) {
//     // ... (Previous code remains unchanged)
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create new Account'),
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Container(
//           // ... (Previous code remains unchanged)
//           InkWell(
//             child: Container(
//               width: w * 0.35,
//               height: h * 0.07,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 image: const DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage('assets/img/loginbtn.png'),
//                 ),
//               ),
//               child: Center(
//                 child: isLoading // Show circular progress indicator if loading
//                     ? CircularProgressIndicator(
//                   color: Colors.white,
//                 )
//                     : Text(
//                   'Send Code',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             onTap: () async {
//               if (_formkey.currentState!.validate()) {
//                 setState(() {
//                   isLoading = true; // Start loading
//                 });
//
//                 try {
//                   await _auth.verifyPhoneNumber(
//                     phoneNumber: phonenumbercontroller.text,
//                     verificationCompleted: (_) {},
//                     verificationFailed: (e) {
//                       utils().toastMessage(e.toString());
//                       setState(() {
//                         isLoading = false; // Stop loading on error
//                       });
//                     },
//                     codeSent: (String verificationID, int? token) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => OTPReceivedScreen(
//                             phoneNumber: phonenumbercontroller.text,
//                             verificationID: verificationID,
//                           ),
//                         ),
//                       );
//                     },
//                     codeAutoRetrievalTimeout: (e) {
//                       utils().toastMessage(e.toString());
//                       setState(() {
//                         isLoading = false; // Stop loading on error
//                       });
//                     },
//                   );
//                 } catch (e) {
//                   utils().toastMessage(e.toString());
//                   setState(() {
//                     isLoading = false; // Stop loading on error
//                   });
//                 }
//               }
//             },
//           ),
//           // ... (Remaining code remains unchanged)
//         ),
//       ),
//     );
//   }
// // ... (Remaining code remains unchanged)
// }
