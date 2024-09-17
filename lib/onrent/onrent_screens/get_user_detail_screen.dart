import 'dart:io';
import 'package:f_container/modules/usermodel.dart';
import 'package:f_container/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../main.dart';
import '../../modules/firebasehelper.dart';
import 'home.dart';


class GetUserDetailScreenOnrent extends StatefulWidget {

  const GetUserDetailScreenOnrent({super.key});


  @override
  State<GetUserDetailScreenOnrent> createState() => _GetUserDetailScreenOnrentState();
}

class _GetUserDetailScreenOnrentState extends State<GetUserDetailScreenOnrent> {
  late UserModel getuserdetail;
  User? firebaseuser = FirebaseAuth.instance.currentUser;
  Future<UserModel?>? userModel;
  List<Map<String, String>> countryCodes = [
    {"code": "+92", "name": "Pak (+92)"},
  ];
  String selectedCountryCode = "+92";
  String phoneNumber = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    userModel = FirebaseHelper1.getUserModelById(firebaseuser!.uid);
    getuserdetail =
        UserModel(name: firstnamecontroller.text.toString(), uid: firebaseuser!.uid);
  }

  @override
  void dispose() {
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    phonenumbercontroller.dispose();
    streetaddresscontroller.dispose();
    citynamecontroller.dispose();
    districtnamecontroller.dispose();
    provincenamecontroller.dispose();
    countrynamecontroller.dispose();
    super.dispose();
  }

  void checkvalues (){
    String firstname = firstnamecontroller.text.trim();
    String lastname = lastnamecontroller.text.trim();
    String phonenumber = phonenumbercontroller.text.trim();
    String streetaddress = streetaddresscontroller.text.trim();
    String cityname = citynamecontroller.text.trim();
    String districtname = districtnamecontroller.text.trim();
    String provincename = provincenamecontroller.text.trim();
    String countryname = countrynamecontroller.text.trim();

    if (firstname == "" || lastname == "" || phonenumber == "" || streetaddress == "" ||
        cityname == "" || districtname == "" || provincename == "" || countryname == "" || imagefile == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the Fields!'),
        ),
      );
    }else {
      UploadData();
    }
  }
  void UploadData () async {
    setState(() {
      isLoading = true;
    });
      UploadTask uploadtask =  FirebaseStorage.instance.ref("Profile"
          "pictures").child(firebaseuser!.uid).putFile(imagefile!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Uploading...!'),
        ),
      );

      TaskSnapshot snapshot = await uploadtask;
      String pimgurl = await snapshot.ref.getDownloadURL();
      String firstname = firstnamecontroller.text.trim();
      String lastname = lastnamecontroller.text.trim();
      String phonenumber = phonenumbercontroller.text.trim();
      String streetaddress = streetaddresscontroller.text.trim();
      String cityname = citynamecontroller.text.trim();
      String districtname = districtnamecontroller.text.trim();
      String provincename = provincenamecontroller.text.trim();
      String countryname = countrynamecontroller.text.trim();
      getuserdetail.fname = firstname;
      getuserdetail.lname = lastname;
      getuserdetail.uid = firebaseuser!.uid;
      getuserdetail.phoneno = phonenumber;
      getuserdetail.district = districtname;
      getuserdetail.address = streetaddress;
      getuserdetail.city = cityname;
      getuserdetail.province = provincename;
      getuserdetail.country = countryname;
      getuserdetail.pimgurl = pimgurl;
      await FirebaseFirestore.instance.collection("User").doc(getuserdetail.uid).set(
          getuserdetail.toMap()
      ).then((value) =>
      {
        setState(() {
          isLoading = false;
        }),
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
      content: Text('Details added successfully!'),
      ),
      ),
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(),))
      }).onError((error, stackTrace) =>
      {
        setState(() {
          isLoading = false;
        }),
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text('Error ${error.toString()}'),
          ),
        ),
      });

  }
  File? imagefile;
  void selectimage(ImageSource source) async {
   XFile? pickedimage = await ImagePicker().pickImage(source: source);

   if(pickedimage != null){
     cropimage(pickedimage);
   }
  }
  void cropimage(XFile file) async {
   CroppedFile? croppedimage =  await ImageCropper().cropImage(
       sourcePath: file.path,
     aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
     compressQuality: 20
   );

   if (croppedimage != null){
     setState(() {
       imagefile = File(croppedimage.path);
     });
   }
  }

  void imageselectedoption() async {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Upload profile picture:"),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Take a photo"),
                onTap: (){
                  Navigator.pop(context);
                  selectimage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Upload from gallery"),
                onTap: (){
                  Navigator.pop(context);
                  selectimage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
  final firstnamecontroller = TextEditingController();
  final lastnamecontroller = TextEditingController();
  final streetaddresscontroller = TextEditingController();
  final phonenumbercontroller = TextEditingController();
  final districtnamecontroller = TextEditingController();
  final citynamecontroller = TextEditingController();
  final provincenamecontroller = TextEditingController();
  final countrynamecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final id = DateTime
      .now()
      .microsecondsSinceEpoch
      .toString();
  // final Future<QuerySnapshot<Map<String, dynamic>>> querySnapshot = FirebaseFirestore.instance.collection(
  // 'User Details').get();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 90, 136, 1),
        title: Text('Enter details'),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: w,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
              Center(
                child: InkWell(
                  onTap: (){
                    imageselectedoption();
                  },
                  child: Container(
                    child: CircleAvatar(
                      backgroundImage: (imagefile != null) ? FileImage(imagefile!) : null,
                      radius: 60,
                      child: (imagefile == null) ? Icon(Icons.person, size: 60) : null,
                    )),
                ),
              ),
                  SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Row(
                      children:  const [
                        Text('First name',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            )),
                        SizedBox(width: 105),
                        Text('Last name',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            )),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: w * 0.41,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromRGBO(46, 90, 136, 1),
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
                              if (value!.isEmpty) {
                                return 'Enter name here';
                              } else {
                                return null;
                              }
                            },
                            controller: firstnamecontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Enter first name',
                                hintStyle: const TextStyle(
                                    color: Colors.white,
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
                        const SizedBox(width: 15),
                        Container(
                          width: w * 0.40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromRGBO(46, 90, 136, 1),
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
                            controller: lastnamecontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Enter last name ',
                                hintStyle: const TextStyle(
                                    color: Colors.white,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.only(left: 17),
                    child: const Text('Phone number',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic

                      ),),
                  ),
                  Container(
                   // margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromRGBO(46, 90, 136, 1),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: const Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2)
                          )
                        ]
                    ),
                    child: IntlPhoneField(
                      dropdownIconPosition: IconPosition.trailing,

                      disableLengthCheck: true,
                      disableAutoFillHints: true,
                      initialCountryCode: 'Pakistan',
                      controller: phonenumbercontroller,
                     invalidNumberMessage: 'Invalid Number try again',
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: 'e.g 3xx-xxxxxxx',
                          hintStyle: const TextStyle(
                              color: Colors.white,
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
                  // Container(
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
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         flex: 5,
                  //         child: DropdownButtonFormField<String>(
                  //           value: selectedCountryCode,
                  //           onChanged: (String? newValue) {
                  //             setState(() {
                  //               selectedCountryCode = newValue!;
                  //             });
                  //           },
                  //           items: countryCodes.map((Map<String, String> country) {
                  //             return DropdownMenuItem<String>(
                  //               value: country["code"],
                  //               child: Text(country["name"]!),
                  //             );
                  //           }).toList(),
                  //           decoration: InputDecoration(
                  //             contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  //             border: InputBorder.none,
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 6,
                  //         child: TextFormField(
                  //           inputFormatters: [
                  //             LengthLimitingTextInputFormatter(10), // Limit to 10 digits
                  //           ],
                  //           validator: (value) {
                  //             if (value!.isEmpty) {
                  //               return 'Enter phone number';
                  //             } else if (value.length < 10) {
                  //               return 'Invalid phone number';
                  //             }
                  //             return null;
                  //           },
                  //           onChanged: (value) {
                  //             setState(() {
                  //               phoneNumber = value;
                  //             });
                  //           },
                  //           keyboardType: TextInputType.phone,
                  //           controller: phonenumbercontroller,
                  //           decoration: InputDecoration(
                  //               hintText: 'e.g: 3xxx-xxxxxxx',
                  //               hintStyle: const TextStyle(
                  //                   color: Colors.grey,
                  //                   fontStyle: FontStyle.italic
                  //               ),
                  //               border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(30),
                  //                   borderSide: const BorderSide(
                  //                     color: Colors.white,
                  //                     width: 1,
                  //                   )
                  //               ),
                  //               enabledBorder: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(30),
                  //                 borderSide: const BorderSide(
                  //                     color: Colors.white,
                  //                     width: 1
                  //                 ),
                  //               ),
                  //               focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(30),
                  //                   borderSide: const BorderSide(
                  //                       color: Colors.white,
                  //                       width: 1
                  //                   )
                  //               )
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.only(left: 17),
                    child: const Text('Street address',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic

                      ),),
                  ),
                  Container(

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromRGBO(46, 90, 136, 1),
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
                        if (value!.isEmpty) {
                          return 'enter street address';
                        } else {
                          return null;
                        }
                      },
                      controller: streetaddresscontroller,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                          hintText: 'Enter street address',
                          hintStyle: const TextStyle(
                              color: Colors.white,
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
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: const [
                        Text('City',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            )),
                        SizedBox(width: 140),
                        Text('District',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            )),


                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: w * 0.41,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromRGBO(46, 90, 136, 1),
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(18), // Limit to 10 digits
                            ],
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter city name';
                              } else {
                                return null;
                              }
                            },
                            controller: citynamecontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Enter city name',
                                hintStyle: const TextStyle(
                                    color: Colors.white,
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
                        const SizedBox(width: 10),
                        Container(
                          width: w * 0.40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromRGBO(46, 90, 136, 1),
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15), // Limit to 10 digits
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter District name';
                              } else {
                                return null;
                              }
                            },
                            controller: districtnamecontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Enter District name',
                                hintStyle: const TextStyle(
                                    color: Colors.white,
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


                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: const [
                        Text('Province',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            )),
                        SizedBox(width: 110),
                        Text('Country',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            )),


                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: w * 0.41,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromRGBO(46, 90, 136, 1),
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
                              if (value!.isEmpty) {
                                return 'Enter Province name';
                              } else {
                                return null;
                              }
                            },
                            controller: provincenamecontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Enter province name',
                                hintStyle: const TextStyle(
                                    color: Colors.white,
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
                        const SizedBox(width: 15),
                        Container(
                          width: w * 0.40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromRGBO(46, 90, 136, 1),
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
                              if (value!.isEmpty) {
                                return 'Enter country name';
                              } else {
                                return null;
                              }
                            },
                            controller: countrynamecontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Enter country name',
                                hintStyle: const TextStyle(
                                    color: Colors.white,
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




                      ],
                    ),
                  ),


                  const SizedBox(height: 20),
                  InkWell(
                      child: Center(
                        child: Container(
                          width: w * 0.36,
                          height: h * 0.07,
                          decoration: BoxDecoration(
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
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        UploadData();
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}