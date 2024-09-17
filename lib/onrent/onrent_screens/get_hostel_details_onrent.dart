import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:path/path.dart' as path;
import 'Onrent_home.dart';
final user= FirebaseAuth.instance.currentUser;


class AddHostelScreenOnrent extends StatefulWidget {
  const AddHostelScreenOnrent({Key? key}) : super(key: key);

  @override
  State<AddHostelScreenOnrent> createState() => _AddHostelScreenOnrentState();
}

class _AddHostelScreenOnrentState extends State<AddHostelScreenOnrent> {
  final hostelnamecontroller = TextEditingController();
  final adressline1controller = TextEditingController();
  final adressline2controller = TextEditingController();
  final areanamecontroller = TextEditingController();
  final citynamecontroller = TextEditingController();
  final provincenamecontroller = TextEditingController();
  final countrynamecontroller = TextEditingController();
  final seatrentcontroller = TextEditingController();
  final roomrentcontroller = TextEditingController();
  final facilitiescontroller = TextEditingController();
  final phonenumbercontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final pickedimage = ImagePicker();
  bool messAvailable = false;
  bool wifiAvailable = false;
  bool parkingAvailable = false;
  String gender = 'Both';
  bool _isLoading = false;
  List<Map<String, String>> countryCodes = [

    {"code": "+92", "name": "+92"},
  ];
  String selectedCountryCode = "+92";
  String phoneNumber = "";
  var firestoreref = FirebaseFirestore.instance.collection('Add new hostel');
  List<File> imageFiles = [];
  List<String> imageUrls = [];
  bool isValidEmailFormat(String email) {
    // Regular expression pattern for a basic email format check
    const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
  final id = DateTime
      .now()
      .microsecondsSinceEpoch
      .toString();
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;

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
        backgroundColor: Color(0xFF2E5A88),
        title: const Text('Add new hostel details'), titleTextStyle: TextStyle( fontSize: 18, color: Colors.black ),
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formkey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    child: const Center(
                      child: Text('Upload image',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,

                        ),),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    child: const Center(
                      child: Text('(Select first image as Thumbnail)',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.black
                        ),),
                    ),
                  ),
                  Container(
                    height: h * 0.19,
                    margin: const EdgeInsets.only(left:1),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageFiles.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return InkWell(
                            onTap: () {
                              imagesSelectedOption();
                            },
                            child: Center(
                              child: Container(
                                width: w * 0.8,
                                height: h * 0.20,
                                margin: const EdgeInsets.only(left: 20, right: 10, top: 1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 7,
                                      offset: const Offset(1, 1),
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.image,
                                      size: 30,
                                      color: Color(0xFF2E5A88),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      'Add Image',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return Container(
                          width: w * 0.5,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              imageFiles[index - 1],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text('Hostle name',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic

                      ),),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF2E5A88),
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
                        LengthLimitingTextInputFormatter(30), // Limit to 10 digits
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter hostel name';
                        } else {
                          return null;
                        }
                      },
                      controller: hostelnamecontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Enter hostel name...',
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
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text('Select Hostel Type',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('Girls Hostel'),
                          value: 'Girls Hostel',
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Boys Hostel'),
                          value: 'Boys Hostel',
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Both'),
                          value: 'Both',
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text(
                      'Mess Available',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.black

                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF2E5A88),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: SwitchListTile(
                      title: const Text('Mess', style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic
                      )),
                      value: messAvailable,
                      onChanged: (value) {
                        setState(() {
                          messAvailable = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text(
                      'WiFi Available',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.black

                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF2E5A88),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: SwitchListTile(
                      title: const Text('WiFi', style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic
                      )),
                      value: wifiAvailable,
                      onChanged: (value) {
                        setState(() {
                          wifiAvailable = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text(
                      'Parking Available',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.black

                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF2E5A88),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: const Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: SwitchListTile(
                      title: const Text('Parking', style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic
                      ),),
                      value: parkingAvailable,
                      onChanged: (value) {
                        setState(() {
                          parkingAvailable = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: const Text('Phone Number',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic

                            ),),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF2E5A88),
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
                        //   margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
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
                        //         flex: 3,
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
                        //           decoration: const InputDecoration(
                        //             contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        //             border: InputBorder.none,
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(
                        //         flex: 5,
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
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: const Text('Email',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic

                            ),),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFF2E5A88),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Email';
                              } else if (!isValidEmailFormat(value)) {
                                return 'Enter a valid Email';
                              }
                              return null;
                            },

                            controller: emailcontroller,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Enter your Email',
                              hintStyle: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text('Adress line 1',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic

                      ),),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF2E5A88),
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
                        LengthLimitingTextInputFormatter(50), // Limit to 10 digits
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter hostel adress';
                        } else {
                          return null;
                        }
                      },
                      controller: adressline1controller,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                          hintText: 'Enter adress line 1',
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
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text('Adress line 2',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic

                      ),),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF2E5A88),
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
                        LengthLimitingTextInputFormatter(50), // Limit to 10 digits
                      ],
                      controller: adressline2controller,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                          hintText: 'Enter adress line 2',
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
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: const [
                        Text('Area',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            )),
                        SizedBox(width: 130),
                        Text('City',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: w * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF2E5A88),
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
                            textCapitalization: TextCapitalization.sentences,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(12), // Limit to 10 digits
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter specific area';
                              } else {
                                return null;
                              }
                            },
                            controller: areanamecontroller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'specific area',
                                hintStyle:  TextStyle(
                                  fontSize: 10,
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
                          width: w * 0.36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF2E5A88),
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
                            textCapitalization: TextCapitalization.sentences,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(18), // Limit to 10 digits
                            ],
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
                                hintText: 'City name',
                                hintStyle: TextStyle(
                                    fontSize: 10,
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
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: const [
                        Text('Province',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            )),
                        SizedBox(width: 100),
                        Text('Country',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: w * 0.36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF2E5A88),
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
                                hintText: 'Province name',
                                hintStyle: const TextStyle(
                                    fontSize: 10,
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
                          width: w * 0.36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF2E5A88),
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
                                hintText: 'Country name',
                                hintStyle: const TextStyle(
                                    fontSize: 10,
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
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: const [
                        Text('Rent per Seat',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            )),
                        SizedBox(width: 62),
                        Text('Rent per room',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: w * 0.36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF2E5A88),
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
                              LengthLimitingTextInputFormatter(5), // Limit to 10 digits
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Seat price';
                              } else {
                                return null;
                              }
                            },
                            controller: seatrentcontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Rent per seat',
                                hintStyle: const TextStyle(
                                    fontSize: 10,
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
                          width: w * 0.36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF2E5A88),
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
                              LengthLimitingTextInputFormatter(5), // Limit to 10 digits
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter room rent';
                              } else {
                                return null;
                              }
                            },
                            controller: roomrentcontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Rent per room',
                                hintStyle: const TextStyle(
                                    fontSize: 10,
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
                  const SizedBox(height: 10),


                  Container(

                    margin: const EdgeInsets.only(left: 30),
                    child: const Text('Facilities we provided',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic

                      ),),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF2E5A88),
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
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 1200,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter details about hostel & facilities';
                        } else {
                          return null;
                        }
                      },
                      controller: facilitiescontroller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Enter details about hostel & facilities...',
                          hintStyle: const TextStyle(
                              fontSize: 10,
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
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black45,
                                  width: 1
                              )
                          )
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 4, right: 8),
                    child: Text(
                      '${facilitiescontroller.text.length}/1200',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  InkWell(
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: w*0.90,
                            height: h * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/img/loginbtn.png'),
                              ),
                            ),
                            child: Center(
                              child: _isLoading // Show circular progress indicator if loading
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : const Text(
                                'Add Hostel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      checkvalues();
                    },
                  ),
                  const SizedBox(height: 20),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkvalues() {
    String hostelname = hostelnamecontroller.text.toString();
    String addressline1 = adressline1controller.text.toString();
    String areaname = areanamecontroller.text.toString();
    String cityname = citynamecontroller.text.toString();
    String provincename = provincenamecontroller.text.toString();
    String countryname = countrynamecontroller.text.toString();
    String rentperseat = seatrentcontroller.text.toString();
    String rentperroom = roomrentcontroller.text.toString();
    String facilities = facilitiescontroller.text.toString();
    String phonenumber = phonenumbercontroller.text.toString();
    String email = emailcontroller.text.toString();

    if (hostelname == "" || addressline1 == "" || areaname == "" ||
        rentperseat == "" || phonenumber == "" || email == "" ||
        cityname == "" || rentperroom == "" || provincename == "" ||
        countryname == "" ||
        facilities == "" || imageFiles == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the Fields!'),
        ),
      );
    } else {
      saveDataToFirebase();
    }
    setState(() {
      _isLoading = false; // Hide CircularProgressIndicator
    });
  }

  Future<void> saveDataToFirebase() async {
    try {
      setState(() {
        _isLoading = true; // Show CircularProgressIndicator
      });
      imgRef = firestoreref.doc(id).collection('Add new hostel');
      for (var imageFile in imageFiles) {
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('Add new hostel/$id/${path.basename(imageFile.path)}');
        await ref.putFile(imageFile);
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Uploading....'),
          ),
        );
      }

      await firestoreref.doc(id).set({
        'hostelname': hostelnamecontroller.text.toString(),
        'adressline1': adressline1controller.text.toString(),
        'adressline2': adressline2controller.text.toString(),
        'areaname': areanamecontroller.text.toString(),
        'cityname': citynamecontroller.text.toString(),
        'provincename': provincenamecontroller.text.toString(),
        'countryname': countrynamecontroller.text.toString(),
        'rentperseat': seatrentcontroller.text.toString(),
        'rentperroom': roomrentcontroller.text.toString(),
        'hostelfacilities': facilitiescontroller.text.toString(),
        'phonenumber': phonenumbercontroller.text.toString(),
        'email': emailcontroller.text.toString(),
        'parkingAvailable': parkingAvailable,
        'messAvailable': messAvailable,
        'wifiAvailable': wifiAvailable,
        'user': user!.uid.toString(),
        'imageUrls': imageUrls,
        'gender': gender,
        'id': id,




      });
      setState(() {
        _isLoading = false; // Show CircularProgressIndicator
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hostel details added successfully!'),
        ),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreenOnrent(),));
    } catch (e) {
      setState(() {
        _isLoading = false; // Show CircularProgressIndicator
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add hostel details: $e'),
        ),
      );
    }
  }



  void selectImages(ImageSource source) async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage();

    if (pickedImages != null) {
      for (var pickedImage in pickedImages) {
        await cropImage(pickedImage);
      }
    }
  }

  Future<void> cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
      compressQuality: 20,
    );

    if (croppedImage != null) {
      setState(() {
        imageFiles.add(File(croppedImage.path));
      });
    }
  }

  void imagesSelectedOption() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Upload Hostel pictures:"),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take photos"),
                  onTap: () {
                    Navigator.pop(context);
                    selectImages(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Upload from gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    selectImages(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

