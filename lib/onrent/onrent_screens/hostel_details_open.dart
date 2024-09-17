import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'hostelimageopen.dart';


class HostelDetailsOpenScreen extends StatefulWidget {
  final String hostelId;

  const HostelDetailsOpenScreen({Key? key,  required this.hostelId}) : super(key: key);

  @override
  _HostelDetailsOpenScreenState createState() => _HostelDetailsOpenScreenState();
}

class _HostelDetailsOpenScreenState extends State<HostelDetailsOpenScreen> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _userStream;
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _userStream = getUserStream(widget.hostelId);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(String hostelId) {
    return FirebaseFirestore.instance.collection('Add new hostel').doc(hostelId).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hostel Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            padding: const EdgeInsets.only(bottom: 50),
            width: w * 0.8,
            child: Column(
              children: [
                const SizedBox(height: 20),
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: _userStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        final userdata = snapshot.data!.data()!;
                        var hostelname = userdata['hostelname'];
                        var hostelfacilities = userdata['hostelfacilities'];
                        var addressline1 = userdata['adressline1'];
                        var addressline2 = userdata['adressline2'];
                        var areaname = userdata['areaname'];
                        var cityname = userdata['cityname'];
                        var provincename = userdata['provincename'];
                        var countryname = userdata['countryname'];
                        var rentperseat = userdata['rentperseat'];
                        var rentperroom = userdata['rentperroom'];
                        var messAvailable = userdata['messAvailable'];
                        var wifiAvailable = userdata['wifiAvailable'];
                        var parkingAvailable = userdata['parkingAvailable'];
                        List<String> hostelimages = List<String>.from(userdata['imageUrls']);
                        var id = userdata['id'];
                        var phonenumber = userdata['phonenumber'];
                        var email = userdata['email'];
                        return Container(
                          width: w * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Center(
                                child: Text(
                                  hostelname,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "Hostel Images",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[600],
                                      fontStyle: FontStyle.italic
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                  width: w*0.8,
                                  height: h*0.25,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: hostelimages.length,
                                    itemBuilder: (context, index ){
                                    if(hostelimages != null){
                                      return InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => HostelImageOpenOnrent(hostelId: id,),));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: Image.network(
                                            hostelimages[index],
                                            // width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }else{
                                      return Container(
                                        width: 10,
                                        height: 10,
                                      );
                                    }



                                    }
                                )
                              ),
                              const SizedBox(height: 15),
                              ShadowedContainer(
                                label: 'Facilities',
                                text: hostelfacilities,
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Services',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[600],
                                              fontStyle: FontStyle.italic
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [

                                            Text(
                                              'Mess',
                                              style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            SizedBox(width: 2,),
                                            messAvailable ? Icon(Icons.check_circle, color: Colors.green, size: 12,) : Icon(Icons.cancel, color: Colors.red, size: 12,),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Text(
                                              'Wifi',
                                              style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            wifiAvailable ? Icon(Icons.check_circle, color: Colors.green, size: 12,) : Icon(Icons.cancel, color: Colors.red, size: 12,),
                                          ],
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Text(
                                              'Parking',
                                              style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                            SizedBox(width: 2),
                                            parkingAvailable ? Icon(Icons.check_circle, color: Colors.green, size: 12,) : Icon(Icons.cancel, color: Colors.red, size: 12,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              ShadowedContainer(
                                label: 'Address',
                                text: '$addressline1\n$addressline2\n$areaname\n$cityname\n$provincename\n$countryname',
                              ),
                              const SizedBox(height: 15),
                              ShadowedContainer(
                                label: 'Rent',
                                text: 'Per Seat: Rs ${double.parse(rentperseat).toStringAsFixed(2)}\nPer Room: Rs ${double.parse(rentperroom).toStringAsFixed(2)}',
                              ),
                              const SizedBox(height: 15),
                              ShadowedContainer(
                                label: 'Contact Information',
                                text: 'Phone Number:  $phonenumber\nEmail: $email',
                              ),
                              const SizedBox(height: 15),

                            ],

                          ),
                        );
                      }
                    }

                    return const CircularProgressIndicator();
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

class ShadowedContainer extends StatelessWidget {
  final String label;
  final String? text;

  const ShadowedContainer({Key? key, required this.label, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[600],
              fontStyle: FontStyle.italic
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text!,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}