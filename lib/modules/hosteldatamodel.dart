class HostelDataModel{
  String? uid;
  String? hostelname;
  String? addressline1;
  String? addressline2;
  String? himgurl;
  String? rentperseat;
  String? rentperroom;
  String? city;
  String? country;
  String? province;
  String? hfacilities;
  String? hdescription;
  String? id;

  HostelDataModel({this.uid, this.hostelname, this.addressline1,  this.addressline2, this.himgurl, this.rentperseat, this.rentperroom,
    this.city, this.country, this.province, this.hdescription, this.hfacilities, this.id,});

  HostelDataModel.fromMap(Map<String, dynamic> map){
    uid = map["uid"];
    hostelname = map["hostelname"];
    addressline1 = map["addressline1"];
    addressline2 = map["addressline2"];
    himgurl = map["himgurl"];
    rentperseat = map["rentperseat"];
    rentperroom = map["rentperroom"];
    city = map["city"];
    country = map["country"];
    hdescription = map["hdescription"];
    hfacilities = map["hfacilities"];
    id= map["id"];
    province= map["province"];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "hostelname": hostelname,
      "addressline1": addressline1,
      "addressline2": addressline2,
      "himgurl": himgurl,
      "rentperseat": rentperseat,
      "rentperroom": rentperroom,
      "city": city,
      "country": country,
      "province": province,
      "hdescription": hdescription,
      "hfacilities": hfacilities,
      "id": id,

    };
  }
}