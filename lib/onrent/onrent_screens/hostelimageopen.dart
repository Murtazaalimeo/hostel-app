// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class HostelImageOpenOnrent extends StatefulWidget {
//   final String hostelId;
//   const HostelImageOpenOnrent({Key? key, required this.hostelId}) : super(key: key);
//
//   @override
//   State<HostelImageOpenOnrent> createState() => _HostelImageOpenOnrentState();
// }
//
// class _HostelImageOpenOnrentState extends State<HostelImageOpenOnrent> {
//   late Stream<DocumentSnapshot<Map<String, dynamic>>> _userStream;
//   @override
//   void initState() {
//     super.initState();
//     _userStream = getUserStream(widget.hostelId);
//   }
//
//   Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(String hostelId) {
//     return FirebaseFirestore.instance.collection('Add new hostel').doc(hostelId).snapshots();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Hostel Images"),
//       ),
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             children: [
//               StreamBuilder(
//                 stream: _userStream,
//                   builder: (BuildContext context,
//                   AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot){
//                   if(snapshot.connectionState == ConnectionState.active){
//                     if(snapshot.hasData){
//                       final userdata = snapshot.data!.data()!;
//                       List<String> hostelimages = List<String>.from(userdata['imageUrls']);
//                       return ListView.builder(
//                         scrollDirection: Axis.vertical,
//                           itemCount: hostelimages.length,
//                           itemBuilder: (context, index ){
//                             var imageUrls = hostelimages[index];
//                             if(hostelimages != null){
//                               return Container(
//                                 height: 300,
//                                 margin: EdgeInsets.only(right: 10),
//                                 child: Image.network(
//                                   hostelimages[index],
//                                   fit: BoxFit.cover,
//                                 ),
//                               );
//                             }else{
//                               return Container();
//                             }
//
//
//
//                           }
//                       );
//                     }
//                   }
//                   return const CircularProgressIndicator();
//                   }
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HostelImageOpenOnrent extends StatelessWidget {
  final String hostelId;

  const HostelImageOpenOnrent({Key? key, required this.hostelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Images'),
      ),
      backgroundColor: Colors.grey.shade400,
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Add new hostel')
            .doc(hostelId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data();
            final List<String> hostelImages =
            List<String>.from(data!['imageUrls']);
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: hostelImages.length,
              itemBuilder: (context, index) {
                final imageUrl = hostelImages[index];
                return Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: w*0.965,
                        height: h*0.3,
                        child: Image.network(imageUrl, fit: BoxFit.cover,

                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

