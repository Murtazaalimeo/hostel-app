import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_container/modules/usermodel.dart';
import 'package:flutter/material.dart';

class FirebaseHelper1 {


  static Future<UserModel?> getUserModelById(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('User').doc(uid).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        return UserModel.fromMap(data);
      }
    } catch (e) {
      print('Error retrieving user model: $e');
    }

    return null;
  }

  static Stream<UserModel> getUserModelStream(String userId) {
    return FirebaseFirestore.instance
        .collection('Add new hostel')
        .doc(userId)
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }
}
