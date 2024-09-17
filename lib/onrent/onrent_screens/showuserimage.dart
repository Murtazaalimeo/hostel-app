import 'package:f_container/modules/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowUserImage extends StatefulWidget {
  final UserModel? currentUser;
  const ShowUserImage({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<ShowUserImage> createState() => _ShowUserImageState();
}

class _ShowUserImageState extends State<ShowUserImage> {
  final User? currentuser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Container(
          child: Image.network(widget.currentUser!.pimgurl!),
        ),
      ),
    );
  }
}
