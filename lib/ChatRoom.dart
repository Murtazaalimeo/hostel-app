import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_container/onrent/onrent_screens/cartview.dart';
import 'package:f_container/onrent/onrent_screens/hostel_details_open.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import 'chat/chatroom.dart';

class HomeScreenOnrent extends StatefulWidget {
  const HomeScreenOnrent({super.key});

  @override
  State<HomeScreenOnrent> createState() => _HomeScreenOnrentState();
}

class _HomeScreenOnrentState extends State<HomeScreenOnrent> {
  final searchcontroller = TextEditingController();
  String selectedGender = 'Both'; // Default value 'both'
  String selectedCity = 'All Cities'; // Default value 'All Cities'

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final firestoreref =
    FirebaseFirestore.instance.collection('Add new hostel').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Onrent.pk'),
        actions: [
          PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (itemCount) => IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartView()),
                );
              },
              icon: Badge(
                label:Text(itemCount.toString()) ,
                child: const Icon(Icons.shopping_bag_outlined,size: 35,),
              ),
            ),
          ),
          const SizedBox(width: 20.0)
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 05, vertical: 10),
          child: Column(
            children: [
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
                child: TextFormField(
                  controller: searchcontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'search by location or name',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
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
                  onChanged: (String Value) {
                    setState(() {});
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<String>(
                      value: selectedCity,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCity = newValue!;
                        });
                      },
                      items: <String>[
                        'All Cities',
                        'Abbottabad',
                        'Astore',
                        'Attock',
                        'Awaran',
                        'Badin',
                        'Bagh',
                        'Bahawalnagar',
                        'Bahawalpur',
                        'Bajaur',
                        'Bannu',
                        'Barkhan',
                        'Batagram',
                        'Bhakkar',
                        'Bhimber',
                        'Buner',
                        'Chagai',
                        'Chakwal',
                        'Charsadda',
                        'Chiniot',
                        'Dadu',
                        'Darel',
                        'Dera Bugti',
                        'DGK',
                        'DIK',
                        'Diamer',
                        'Duki',
                        'Faisalabad',
                        'Ghanche',
                        'Ghizer',
                        'Ghotki',
                        'Gilgit',
                        'Gujranwala',
                        'Gujrat',
                        'Gupis Yasin',
                        'Gwadar',
                        'Hafizabad',
                        'Hangu',
                        'Haripur',
                        'Harnai',

                      ].map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                    //SizedBox(width: 100,),
                    DropdownButton<String>(
                      value: selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue!;
                        });
                      },
                      items: <String>[
                        'Both',
                        'Boys Hostel',
                        'Girls Hostel',
                      ].map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: firestoreref,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('error'));
                  }

                  List<QueryDocumentSnapshot> filteredHostels =
                  snapshot.data!.docs
                      .where((doc) =>
                  (selectedGender == 'Both' ||
                      doc['gender'] == selectedGender) &&
                      (selectedCity == 'All Cities' ||
                          doc['cityname'] == selectedCity))
                      .toList();
                  if (filteredHostels.isEmpty) {
                    return Center(child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Text('Coming Soon...')));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: filteredHostels.length,
                      itemBuilder: (context, index) {
                        final snap = filteredHostels[index];

                        final hostelname = snap['hostelname'].toString();
                        final areaname = snap['areaname'].toString();
                        final seatrent = snap['rentperseat'].toString();
                        final cityname = snap['cityname'].toString();
                        final id = snap['id'].toString();
                        final email = snap['email'].toString();
                        final bool messAvailable = snap['messAvailable'];
                        final bool wifiAvailable = snap['wifiAvailable'];
                        final provincename = snap['provincename'].toString();
                        final countryname = snap['countryname'].toString();
                        final bool parkingAvailable =
                        snap['parkingAvailable'];
                        List<String> hostelimages =
                            (snap['imageUrls'] as List<dynamic>?)
                                ?.cast<String>() ?? [];
                        if(searchcontroller.text.isEmpty){
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HostelDetailsOpenScreen(
                                    hostelId: id,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 10,
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                              width: w,
                              height: h * 0.44,
                            ),
                          );
                        } else if(areaname.toLowerCase().contains(searchcontroller.text.toLowerCase().toString()) ||
                            hostelname.toLowerCase().contains(searchcontroller.text.toLowerCase().toString()) ||
                            provincename.toLowerCase().contains(searchcontroller.text.toLowerCase().toString()) ||
                            cityname.toLowerCase().contains(searchcontroller.text.toLowerCase().toString()) ||
                            countryname.toLowerCase().contains(searchcontroller.text.toLowerCase().toString())){
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HostelDetailsOpenScreen(
                                    hostelId: id,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 10,
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                              width: w,
                              height: h * 0.34,

                            ),
                          );
                        } else {
                          return Container(
                            // child: Text('no data found'),
                          );
                        }


                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
