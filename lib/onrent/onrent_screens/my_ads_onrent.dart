import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_container/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'get_hostel_details_onrent.dart';
User? user = FirebaseAuth.instance.currentUser;
String userid = user!.uid;
class MyAdsScreenOnrent extends StatefulWidget {
  const MyAdsScreenOnrent({Key? key}) : super(key: key);

  @override
  State<MyAdsScreenOnrent> createState() => MyAdsScreenOnrentState();
}

class MyAdsScreenOnrentState extends State<MyAdsScreenOnrent> {
  var hostelnameeditingcontroller = TextEditingController();
  var addressline1editingcontroller = TextEditingController();
  var addressline2editingcontroller = TextEditingController();
  var citynameeditingcontroller = TextEditingController();
  var areanameeditingcontroller = TextEditingController();
  var provincenameeditingcontroller = TextEditingController();
  var countrynameeditingcontroller = TextEditingController();
  var rentperroomeditingcontroller = TextEditingController();
  var rentperseateditingcontroller = TextEditingController();
  var facilitieseditingcontroller = TextEditingController();
  int id = DateTime.now().microsecondsSinceEpoch.toInt();
  String gender = 'Both';


  CollectionReference ref = FirebaseFirestore.instance.collection('Add new hostel');
  final firestoreref = FirebaseFirestore.instance.collection('Add new hostel').snapshots();
  final  snapshot = FirebaseFirestore.instance.collection('Add new hostel')
      .where('userid', isEqualTo: userid).get();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ads'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
            .collection('Add new hostel')
            .where('user', isEqualTo: user!.uid)
            .snapshots(),
                builder: (BuildContext contex,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if(snapshot.hasError) {
                    return const Text('error');
                  }
                  if(snapshot.data == null){
                    return Center(
                      child: TextButton( onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddHostelScreenOnrent(),));
                      }, child: Text("Add Hostel", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),) ),
                    );
                  }

                  return  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          final snap = snapshot.data!.docs[index];
                          final hostelnamecontroller = snap['hostelname'].toString();
                          final areanamecontroller = snap['areaname'].toString();
                          final citynamecontroller = snap['cityname'].toString();
                          final addressline1controller = snap['adressline1'].toString();
                          final addressline2controller = snap['adressline2'].toString();
                          final provincenamecontroller = snap['provincename'].toString();
                          final countrynamecontroller = snap['countryname'].toString();
                          final rentperseatcontroller = snap['rentperseat'].toString();
                          final rentperroomcontroller = snap['rentperroom'].toString();
                          final facilitiescontroller = snap['hostelfacilities'].toString();
                          bool messAvailable = snap['messAvailable'];
                          bool wifiAvailable = snap['wifiAvailable'];
                          bool parkingAvailable = snap['parkingAvailable'];
                          final gender = snap['gender'];

                          List<String> hostelimages = List<String>.from(snap['imageUrls']);
                          final id = snapshot.data!.docs[index]['id'].toString();
                          if(snap != null){
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 08),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 10,
                                        color: Colors.grey.withOpacity(0.3),
                                        offset: const Offset(1, 1)
                                    )
                                  ]
                              ),
                              width: w,
                              height: h*0.34,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                        width: w * 0.78,
                                        height: h * 0.2,
                                        child: Image.network(
                                          hostelimages.isNotEmpty ? hostelimages[0] : '',
                                          fit: BoxFit.fitWidth,
                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) {
                                              // Image has finished loading or failed to load
                                              if (child is Image) {
                                                if (child.width! > 0 && child.height! > 0) {
                                                  // Image loaded successfully
                                                  return child;
                                                } else {
                                                  // Image failed to load (blank image or network error)
                                                  return Center(
                                                    child: Text('Image failed to load'),
                                                  );
                                                }
                                              }
                                              return child; // Return the placeholder widget if not an Image
                                            } else {
                                              // Image is still loading
                                              final expectedTotalBytes = loadingProgress.expectedTotalBytes;
                                              final cumulativeBytesLoaded = loadingProgress.cumulativeBytesLoaded;
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value: expectedTotalBytes != null
                                                      ? cumulativeBytesLoaded / expectedTotalBytes
                                                      : null,
                                                ),
                                              );
                                            }
                                          },
                                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                            // Error occurred while loading the image
                                            return Center(
                                              child: Text('Error loading image'),
                                            );
                                          },
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: PopupMenuButton(
                                              icon: const Icon(Icons.more_vert),
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                    child: ListTile(
                                                      leading: const Icon(Icons.edit),
                                                      title: const Text('Edit'),
                                                      onTap: (){
                                                        Navigator.pop(context);
                                                        showmydilouge(hostelnamecontroller, id, addressline1controller, citynamecontroller,
                                                            addressline2controller, areanamecontroller, provincenamecontroller, countrynamecontroller,
                                                            rentperseatcontroller, rentperroomcontroller, facilitiescontroller,  messAvailable,
                                                            wifiAvailable, parkingAvailable, gender);
                                                      },
                                                    )),
                                                PopupMenuItem(
                                                    child: ListTile(
                                                      leading: const Icon(Icons.delete),
                                                      title: const Text('Delete'),
                                                      onTap: (){
                                                        Navigator.pop(context);
                                                        deletedilouge(id);
                                                      },
                                                    ))
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    width: w,
                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(right: 10, left: 5),
                                          height: 20,
                                          child: Text(hostelnamecontroller, style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                        Container(
                                          width: w,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: w*0.6,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        child: Row(
                                                          children: [
                                                            const Icon(Icons.location_on_outlined),
                                                            const SizedBox(width: 3),
                                                            Text(areanamecontroller),
                                                            const Text(', '),
                                                            Text(citynamecontroller)
                                                          ],
                                                        )
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets.only(top: 2, left: 5),
                                                        child: RichText(text:
                                                        TextSpan(
                                                            style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                                                            children: [
                                                              const TextSpan(text: 'Avg price, '),
                                                              TextSpan(text: 'PKR $rentperseatcontroller', style: const TextStyle(color: Colors.blue, fontSize: 14, fontStyle: FontStyle.italic)),
                                                              const TextSpan(text: '/mon')
                                                            ]
                                                        ))
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Mess',
                                                          style: TextStyle(
                                                            // fontWeight: FontWeight.bold,
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontStyle: FontStyle.italic,
                                                          ),
                                                        ),
                                                        messAvailable ? const Icon(Icons.check_circle, color: Colors.green, size: 12,) : const Icon(Icons.cancel, color: Colors.red, size: 12,),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Wifi',
                                                          style: TextStyle(
                                                            // fontWeight: FontWeight.bold,
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontStyle: FontStyle.italic,
                                                          ),
                                                        ),
                                                        wifiAvailable ? const Icon(Icons.check_circle, color: Colors.green, size: 12,) : const Icon(Icons.cancel, color: Colors.red, size: 12,),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Parking',
                                                          style: TextStyle(
                                                            // fontWeight: FontWeight.bold,
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontStyle: FontStyle.italic,
                                                          ),
                                                        ),
                                                        parkingAvailable ? const Icon(Icons.check_circle, color: Colors.green, size: 12,) : const Icon(Icons.cancel, color: Colors.red, size: 12,),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )

                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),

                            );
                          }else{
                            Center(child: InkWell(
                                onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AddHostelScreenOnrent(),));},
                                child: const Text('Add Hostel, if you have')));
                          }
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
  Future<void> showmydilouge(String hostelnamecontroller, String id, String citynamecontroller, String addressline1controller,
      String addressline2controller, String areanamecontroller, String provincenamecontroller, String countrynamecontroller,
      String rentperseatcontroller, String rentperroomcontroller, String facilitiescontroller,  bool messAvailable,
      bool wifiAvailable, bool parkingAvailable, String gender)async{
    hostelnameeditingcontroller.text = hostelnamecontroller;
    addressline1editingcontroller.text = addressline1controller;
    addressline2editingcontroller.text = addressline2controller;
    citynameeditingcontroller.text = citynamecontroller;
    areanameeditingcontroller.text = areanamecontroller;
    provincenameeditingcontroller.text = provincenamecontroller;
    countrynameeditingcontroller.text = countrynamecontroller;
    facilitieseditingcontroller.text = facilitiescontroller;
    rentperseateditingcontroller.text = rentperseatcontroller;
    rentperroomeditingcontroller.text = rentperroomcontroller;
    messAvailable = messAvailable;
    wifiAvailable = wifiAvailable;
    parkingAvailable = parkingAvailable;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: AlertDialog(
              title: const Text('Update'),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Container(
                    //   child: Center(
                    //     child: const Text('Upload images upto 10',
                    //       style: TextStyle(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold,
                    //           fontStyle: FontStyle.italic
                    //
                    //       ) ,),
                    //   ),
                    // ),
                    // Container(
                    //   height: h*0.17,
                    //   margin: const EdgeInsets.only(top: 5),
                    //   child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: _images.length+1,
                    //       itemBuilder: (context, index){
                    //         return index == 0
                    //             ? InkWell(
                    //           onTap: (){chooseimage();},
                    //           child: Center(
                    //             child: Container(
                    //               width: w*0.5,
                    //               height: h*0.17,
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(10),
                    //                   color: Colors.white,
                    //                   boxShadow: [
                    //                     BoxShadow(
                    //                         blurRadius: 10,
                    //                         spreadRadius: 7,
                    //                         offset: const Offset(1, 1),
                    //                         color: Colors.grey.withOpacity(0.2)
                    //                     )
                    //                   ]
                    //               ),
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   Icon(Icons.image, size: 25,),
                    //                   SizedBox(height: 3,),
                    //                   Text('Add images', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ): Container(
                    //           width: w*0.5,
                    //           height: h*0.17,
                    //           margin: EdgeInsets.all(3),
                    //           decoration: BoxDecoration(image: DecorationImage(image: FileImage(_images[index-1]), fit: BoxFit.cover)),
                    //         );
                    //       }
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    Container(
                      child: const Text('Hostle name',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic

                        ) ,),
                    ),
                    Container(
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(30), // Limit to 10 digits
                        ],
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'please enter hostel name';
                          } else {
                            return null;
                          }
                        },
                        controller: hostelnameeditingcontroller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Enter hostel name...',
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
                    const SizedBox(height: 10),
                    Container(
                      child: const Text('Select Hostel Type',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                    Container(
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
                      // margin: const EdgeInsets.only(left: 30),
                      child: const Text(
                        'Mess available',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Container(
                      // margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
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
                      child: SwitchListTile(
                        title: const Text('Mess',style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic
                        ),),
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
                     // margin: const EdgeInsets.only(left: 30),
                      child: const Text(
                        'WiFi available',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Container(
                     // margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
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
                      child: SwitchListTile(
                        title: const Text('WiFi',style: TextStyle(
                            color: Colors.grey,
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
                     // margin: const EdgeInsets.only(left: 30),
                      child: const Text(
                        'Parking available',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Container(
                     // margin: const EdgeInsets.only(left: 20, right: 20, top: 1),
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
                      child: SwitchListTile(
                        title: const Text('Parking',style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic
                        )),
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
                      child: const Text('Address line 1',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic

                        ) ,),
                    ),
                    Container(
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50), // Limit to 10 digits
                        ],
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'enter hostel address';
                          } else {
                            return null;
                          }
                        },
                        controller: addressline1editingcontroller,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                            hintText: 'Enter address line 1',
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
                    const SizedBox(height: 10),
                    Container(
                      child: const Text('Address line 2',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic

                        ) ,),
                    ),
                    Container(
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(50), // Limit to 10 digits
                        ],
                        controller: addressline2editingcontroller,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                            hintText: 'Enter address line 2',
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
                    const SizedBox(height: 10),
                    Container(
                      child: const Text('Area',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                          )),
                    ),
                    Container(
                      child: Container(
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15), // Limit to 10 digits
                          ],
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Enter specific area';
                            } else {
                              return null;
                            }
                          },
                          controller: areanameeditingcontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: 'specific area',
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
                    const SizedBox(height: 10),
                    Container(
                      child: const Text('City',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                          )),
                    ),
                    Container(
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(18), // Limit to 10 digits
                        ],
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Enter city name';
                          } else {
                            return null;
                          }
                        },
                        controller: citynameeditingcontroller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'City name',
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
                    const SizedBox(height: 10),
                    Container(
                      child: const Text('Province',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                          )),
                    ),
                    Container(
                      child: Container(
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
                              return 'Enter Province name';
                            } else {
                              return null;
                            }
                          },
                          controller: provincenameeditingcontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: 'Province name',
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
                    const SizedBox(height: 10),
                    Container(
                      child: const Text('Country',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                          )),
                    ),
                    Container(
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
                            return 'Enter country name';
                          } else {
                            return null;
                          }
                        },
                        controller: countrynameeditingcontroller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Country name',
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
                    const SizedBox(height: 10),
                    Container(
                      child: const Text('Rent per Seat',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                          )),
                    ),
                    Container(
                      child: Container(
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5), // Limit to 10 digits
                          ],
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'Enter Seat price';
                            } else {
                              return null;
                            }
                          },
                          controller: rentperseateditingcontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Rent per seat',
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
                    const SizedBox(height: 10),
                    Container(
                      child: const Text('Rent per Room',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                          )),
                    ),
                    Container(
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5), // Limit to 10 digits
                        ],
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Enter room rent';
                          } else {
                            return null;
                          }
                        },
                        controller: rentperroomeditingcontroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Rent per room',
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
                    const SizedBox(height: 10),
                    Container(
                      child: const Text('Facalities we provided',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic

                        ) ,),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                        maxLines: 4,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Enter facilities of hostel';
                          } else {
                            return null;
                          }
                        },
                        controller: facilitieseditingcontroller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Enter facilities you provided...',
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
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                  child: const Text('Update'),
                  onPressed: (){
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Uploading...'),
                      ),
                    );
                    ref.doc(id).update({
                      'hostelname': hostelnameeditingcontroller.text.toString(),
                      'adressline1':addressline1editingcontroller.text.toString(),
                      'adressline2':addressline1editingcontroller.text.toString(),
                      'areaname': areanameeditingcontroller.text.toString(),
                      'cityname': citynameeditingcontroller.text.toString(),
                      'provincename':provincenameeditingcontroller.text.toString(),
                      'countryname':countrynameeditingcontroller.text.toString(),
                      'rentperseat': rentperseateditingcontroller.text.toString(),
                      'rentperroom': rentperroomeditingcontroller.text.toString(),
                      'hostelfacilities': facilitieseditingcontroller.text.toString(),
                      'messAvailable': messAvailable,
                      'wifiAvailable': wifiAvailable,
                      'parkingAvailable': parkingAvailable,
                      'gender': gender

                    }).then((value) => {
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                    content: Text('Updated Successfully'),
                    ),
                    )
                    }).onError((error, stackTrace) => {
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                    content: Text('error'),
                    ),
                    )

                    });
                  },)

              ],
            ),
          );
        }
    );
  }
  Future<void> deletedilouge(String id){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Are you Sure to delete it?'),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    ref.doc(id).delete().then((value) => {
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                    content: Text('Deleted Successfully'),
                    ),
                    )

                    }).onError((error, stackTrace) => {
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                    content: Text('error'),
                    ),
                    )
                    });
                  },
                  child: const Text('Delete'))
            ],


          );
        });
  }
}

