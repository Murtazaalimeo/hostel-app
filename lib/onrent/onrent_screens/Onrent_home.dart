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
        title: const Text('Onrent hostel rental app', style: TextStyle(fontSize: 18), // Adjust font size here
      ),
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
                        'Hattian',
                        'Haveli',
                        'Hunza',
                        'Hyderabad',
                        'Islamabad',
                        'Jacobabad',
                        'Jafarabad',
                        'Jamshoro',
                        'Jhal Magsi',
                        'Jhang',
                        'Jhelum',
                        'Kachhi',
                        'Kalat',
                        'Karachi',
                        'Karak',
                        'Kashmore',
                        'Kasur',
                        'Kech',
                        'Khairpur',
                        'Khanewal',
                        'Kharan',
                        'Kharmang',
                        'Khushab',
                        'Khuzdar',
                        'Khyber',
                        'Kohat',
                        'Kohlu',
                        'Korangi',
                        'Kotli',
                        'Kurram',
                        'Lahore',
                        'Lakki Marwat',
                        'Larkana',
                        'Lasbela',
                        'Layyah',
                        'Lodhran',
                        'Loralai',
                        'Lower Dir',
                        'Malakand',
                        'Malir',
                        'Mandi Bahauddin',
                        'Mansehra',
                        'Mardan',
                        'Mastung',
                        'Matiari',
                        'Mianwali',
                        'Mirpur Khas',
                        'Mirpur',
                        'Mohmand',
                        'Multan',
                        'Musakhel',
                        'Muzaffarabad',
                        'Muzaffargarh',
                        'Nagar',
                        'Nankana Sahib',
                        'Narowal',
                        'Naseerabad',
                        'Neelum',
                        'Nowshera',
                        'Nushki',
                        'Okara',
                        'Orakzai',
                        'Pakpattan',
                        'Panjgur',
                        'Peshawar',
                        'Pishin',
                        'Poonch',
                        'Quetta',
                        'RYK',
                        'Rajanpur',
                        'Rawalpindi',
                        'Roundu',
                        'Sahiwal',
                        'Sanghar',
                        'Sargodha',
                        'Shangla',
                        'Sheikhupura',
                        'Sherani',
                        'Shigar',
                        'Shikarpur',
                        'Sialkot',
                        'Sibi',
                        'Skardu',
                        'Sohbatpur',
                        'Sudhnutti',
                        'Sujawal',
                        'Sukkur',
                        'Swabi',
                        'Swat',
                        'Tangir',
                        'Tank',
                        'Thatta',
                        'Tor Ghar',
                        'Umerkot',
                        'Upper Dir',
                        'Vehari',
                        'Washuk',
                        'Zhob',
                        'Ziarat',
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                  //   width: w * 0.78,
                                  //   height: h * 0.2,
                                  //   child: Image.network(
                                  //     hostelimages.isNotEmpty ? hostelimages[0] : '',
                                  //     fit: BoxFit.fitWidth,
                                  //     loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  //       if (loadingProgress == null) {
                                  //         // Image has finished loading or failed to load
                                  //         if (child is Image) {
                                  //           if (child.image != null && child.image.width > 0 && child.image.height > 0) {
                                  //             // Image loaded successfully
                                  //             return child;
                                  //           } else {
                                  //             // Image failed to load (blank image or network error)
                                  //             return Center(
                                  //               child: Text('Image failed to load'),
                                  //             );
                                  //           }
                                  //         }
                                  //         return child; // Return the placeholder widget if not an Image
                                  //       } else {
                                  //         // Image is still loading
                                  //         return Center(
                                  //           child: CircularProgressIndicator(
                                  //             value: loadingProgress.expectedTotalBytes != null
                                  //                 ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                  //                 : null,
                                  //           ),
                                  //         );
                                  //       }
                                  //     },
                                  //     errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                  //       // Error occurred while loading the image
                                  //       return Center(
                                  //         child: Text('Error loading image'),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                    //container size for home whole one hostel
                                    width: w * 0.78,
                                    height: h * 0.19,
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
                                          child: Text('Error loading image check network connection'),
                                        );
                                      },
                                    ),
                                  )

                                  ,




                                  const SizedBox(height: 10),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    width: w,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                            left: 5,
                                          ),
                                          height: 12,
                                          child: Text(
                                            hostelname,
                                            style: const TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: w,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: w * 0.6,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(areaname),
                                                          const Text(','),
                                                          Text(cityname,style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12
                                                          ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                      const EdgeInsets.only(
                                                        top: 2,
                                                        left: 5,
                                                      ),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontStyle:
                                                            FontStyle.italic,
                                                          ),
                                                          children: [
                                                            const TextSpan(
                                                              text: 'Avg price, ',
                                                            ),
                                                            TextSpan(
                                                              text:
                                                              'PKR $seatrent',
                                                              style:
                                                              const TextStyle(
                                                                color:
                                                                Colors.black,
                                                                fontSize: 14,
                                                                fontStyle:
                                                                FontStyle
                                                                    .italic,
                                                              ),
                                                            ),
                                                            const TextSpan(
                                                              text: '/mon',
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                      const EdgeInsets.only(
                                                        top: 2,
                                                        left: 5,
                                                      ),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                            fontStyle:
                                                            FontStyle.italic,
                                                          ),
                                                          children: [
                                                            // TextSpan(
                                                            //   text:
                                                            //   'id : $id',
                                                            //   style:
                                                            //   const TextStyle(
                                                            //     color:
                                                            //     Colors.orange,
                                                            //     fontSize: 14,
                                                            //     fontStyle:
                                                            //     FontStyle
                                                            //         .italic,
                                                            //   ),
                                                            //
                                                            // ),
                                                        TextSpan(
                                                          text:
                                                          'email : $email',
                                                          style:
                                                          const TextStyle(
                                                            color:
                                                            Colors.black,
                                                            fontSize: 12,
                                                            fontStyle:
                                                            FontStyle
                                                                .italic,
                                                          ),
                                                        ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                            builder: (_) => ChatRoom(
                                                              chatRoomId: id,
                                                              userMap: {},
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(12),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey.withOpacity(0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 2,
                                                              offset: const Offset(0, 1), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.chat_bubble_outline,
                                                              color: Colors.deepPurpleAccent,
                                                              size: 16,
                                                            ),
                                                            const SizedBox(width: 6),
                                                            Text(
                                                              'Chat with user',
                                                              style: TextStyle(
                                                                color: Colors.deepPurpleAccent,
                                                                fontStyle: FontStyle.italic,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    Container(
                                                      child: PersistentShoppingCart().showAndUpdateCartItemWidget(
                                                        inCartWidget: Container(
                                                          height: 30,
                                                          width: 70,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            border: Border.all(color: Colors.red),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              'Remove',
                                                              style: Theme.of(context).textTheme.bodySmall,
                                                            ),
                                                          ),
                                                        ),
                                                        notInCartWidget: Container(
                                                          height: 30,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                            border: Border.all(color: Colors.green),
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                                            child: Center(
                                                              child: Text(
                                                                'Add to cart',
                                                                style: Theme.of(context).textTheme.bodySmall,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        product: PersistentShoppingCartItem(
                                                          productId: id,
                                                          productName: hostelname,
                                                          quantity: 1,
                                                          unitPrice:double.parse(seatrent.toString()),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Mess',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontStyle:
                                                            FontStyle.italic,
                                                          ),
                                                        ),
                                                        messAvailable
                                                            ? const Icon(
                                                          Icons
                                                              .check_circle,
                                                          color:
                                                          Colors.green,
                                                          size: 12,
                                                        )
                                                            : const Icon(
                                                          Icons.cancel,
                                                          color:
                                                          Colors.red,
                                                          size: 12,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Wifi',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontStyle:
                                                            FontStyle.italic,
                                                          ),
                                                        ),
                                                        wifiAvailable
                                                            ? const Icon(
                                                          Icons
                                                              .check_circle,
                                                          color:
                                                          Colors.green,
                                                          size: 12,
                                                        )
                                                            : const Icon(
                                                          Icons.cancel,
                                                          color:
                                                          Colors.red,
                                                          size: 12,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Parking',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontStyle:
                                                            FontStyle.italic,
                                                          ),
                                                        ),
                                                        parkingAvailable
                                                            ? const Icon(
                                                          Icons
                                                              .check_circle,
                                                          color:
                                                          Colors.green,
                                                          size: 12,
                                                        )
                                                            : const Icon(
                                                          Icons.cancel,
                                                          color:
                                                          Colors.red,
                                                          size: 12,
                                                        ),
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                  //   width: w * 0.78,
                                  //   height: h * 0.2,
                                  //   child: Image.network(
                                  //     hostelimages.isNotEmpty ? hostelimages[0] : '',
                                  //     fit: BoxFit.fitWidth,
                                  //     loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  //       if (loadingProgress == null) {
                                  //         // Image has finished loading or failed to load
                                  //         if (child is Image) {
                                  //           if (child.image != null && child.image.width > 0 && child.image.height > 0) {
                                  //             // Image loaded successfully
                                  //             return child;
                                  //           } else {
                                  //             // Image failed to load (blank image or network error)
                                  //             return Center(
                                  //               child: Text('Image failed to load'),
                                  //             );
                                  //           }
                                  //         }
                                  //         return child; // Return the placeholder widget if not an Image
                                  //       } else {
                                  //         // Image is still loading
                                  //         return Center(
                                  //           child: CircularProgressIndicator(
                                  //             value: loadingProgress.expectedTotalBytes != null
                                  //                 ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                  //                 : null,
                                  //           ),
                                  //         );
                                  //       }
                                  //     },
                                  //     errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                  //       // Error occurred while loading the image
                                  //       return Center(
                                  //         child: Text('Error loading image'),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),
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
                                          child: Text('Error loading image check network connection'),
                                        );
                                      },
                                    ),
                                  )

                                  ,




                                  const SizedBox(height: 10),
                                  Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    width: w,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                            left: 5,
                                          ),
                                          height: 20,
                                          child: Text(
                                            hostelname,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: w,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: w * 0.6,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                          ),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(areaname),
                                                          const Text(', '),
                                                          Text(cityname),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                      const EdgeInsets.only(
                                                        top: 2,
                                                        left: 5,
                                                      ),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontStyle:
                                                            FontStyle.italic,
                                                          ),
                                                          children: [
                                                            const TextSpan(
                                                              text: 'Avg price, ',
                                                            ),
                                                            TextSpan(
                                                              text:
                                                              'PKR $seatrent',
                                                              style:
                                                              const TextStyle(
                                                                color:
                                                                Colors.black,
                                                                fontSize: 14,
                                                                fontStyle:
                                                                FontStyle
                                                                    .italic,
                                                              ),
                                                            ),
                                                            const TextSpan(
                                                              text: '/mon',
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Mess',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontStyle:
                                                            FontStyle.italic,
                                                          ),
                                                        ),
                                                        messAvailable
                                                            ? const Icon(
                                                          Icons
                                                              .check_circle,
                                                          color:
                                                          Colors.green,
                                                          size: 12,
                                                        )
                                                            : const Icon(
                                                          Icons.cancel,
                                                          color:
                                                          Colors.red,
                                                          size: 12,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Wifi',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontStyle:
                                                            FontStyle.italic,
                                                          ),
                                                        ),
                                                        wifiAvailable
                                                            ? const Icon(
                                                          Icons
                                                              .check_circle,
                                                          color:
                                                          Colors.green,
                                                          size: 12,
                                                        )
                                                            : const Icon(
                                                          Icons.cancel,
                                                          color:
                                                          Colors.red,
                                                          size: 12,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          'Parking',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontStyle:
                                                            FontStyle.italic,
                                                          ),
                                                        ),
                                                        parkingAvailable
                                                            ? const Icon(
                                                          Icons
                                                              .check_circle,
                                                          color:
                                                          Colors.green,
                                                          size: 12,
                                                        )
                                                            : const Icon(
                                                          Icons.cancel,
                                                          color:
                                                          Colors.red,
                                                          size: 12,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
