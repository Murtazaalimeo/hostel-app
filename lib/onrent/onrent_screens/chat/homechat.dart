import 'package:f_container/onrent/onrent_screens/chat/chatroom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LimitedDataPage extends StatefulWidget {
  @override
  _LimitedDataPageState createState() => _LimitedDataPageState();
}

class _LimitedDataPageState extends State<LimitedDataPage> {
  late Stream<QuerySnapshot> _limitedDataStream;

  @override
  void initState() {
    super.initState();
    // Fetch limited data from Firestore
    _limitedDataStream = FirebaseFirestore.instance
        .collection('Add new hostel')
        .limit(10) // Limit the number of documents
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All users'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _limitedDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final doc = documents[index];
              final hostelname = doc['hostelname'];
              final areaname = doc['areaname'];
              final cityname = doc['cityname'];
              final id = doc['id'];

              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hostelname,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10, // Decrease font size
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chat),
                        onPressed: () {
                          _navigateToChatRoom(hostelname);
                        },
                      ),
                    ],
                  ),
                  subtitle: Text('$areaname, $cityname'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    _navigateToChatRoom(hostelname);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _navigateToChatRoom(String hostelname) async {
    // Retrieve the user ID from Firebase Authentication
    final user = await FirebaseAuth.instance.currentUser;
    String userId = user != null ? user.uid : '';

    // Concatenate the user ID and hostel name to create the chat room ID
    String roomId = '$userId-$hostelname';

    // Navigate to the chat room page and pass the chat room ID and hostel name
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoom(
          chatRoomId: roomId,
          userMap: {}, // Pass the user map here if needed
         // Pass the hostel name
        ),
      ),
    );
  }
}
