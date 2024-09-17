import 'dart:developer';

class UserModel{
  String? uid;
  String? fname;
  String? lname;
  String? pimgurl;
  String? phoneno;
  String? address;
  String? district;
  String? city;
  String? country;
  String? province;

  UserModel({this.uid, this.fname, this.lname,  this.pimgurl, this.phoneno, this.address, this.district,
  this.city, this.country, this.province, required name});

  UserModel.fromMap(Map<String, dynamic> map){
    uid = map["uid"];
    fname = map["fname"];
    lname = map["lname"];
    pimgurl = map["pimgurl"];
    phoneno = map["phoneno"];
    address = map["address"];
    district = map["district"];
    city = map["city"];
    country = map["country"];
    province= map["province"];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fname": fname,
      "lname": lname,
      "pimgurl": pimgurl,
      "phoneno": phoneno,
      "address": address,
      "district": district,
      "city": city,
      "country": country,
      "province": province,
  };
  }
}