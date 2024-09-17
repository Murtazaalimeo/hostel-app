import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JazzCash extends StatefulWidget {
  JazzCash({Key? key}) : super(key: key);

  @override
  _JazzCashState createState() => _JazzCashState();
}

class _JazzCashState extends State<JazzCash> {
  var responcePrice;
  bool isLoading = false;

  // Function to initiate JazzCash payment with user details
  payment(String accountNo, String price) async {
    setState(() {
      isLoading = true;
    });

    // Generate transaction details
    String dateandtime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
    String dexpiredate = DateFormat("yyyyMMddHHmmss").format(
        DateTime.now().add(const Duration(days: 1)));
    String tre = "T" + dateandtime;
    String pp_Amount = price;
    String pp_BillReference = "billRef";
    String pp_Description = "Description";
    String pp_Language = "EN";
    String pp_MerchantID = "MC76331";
    String pp_Password = "e83ttcs992";

    String pp_ReturnURL = "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
    String pp_ver = "1.1";
    String pp_TxnCurrency = "PKR";
    String pp_TxnDateTime = dateandtime.toString();
    String pp_TxnExpiryDateTime = dexpiredate.toString();
    String pp_TxnRefNo = tre.toString();
    String pp_TxnType = "MWALLET";
    String ppmpf_1 = "4456733833993";
    String IntegeritySalt = "Your salt";

    String superdata = IntegeritySalt +
        '&' +
        pp_Amount +
        '&' +
        pp_BillReference +
        '&' +
        pp_Description +
        '&' +
        pp_Language +
        '&' +
        pp_MerchantID +
        '&' +
        pp_Password +
        '&' +
        pp_ReturnURL +
        '&' +
        pp_TxnCurrency +
        '&' +
        pp_TxnDateTime +
        '&' +
        pp_TxnExpiryDateTime +
        '&' +
        pp_TxnRefNo +
        '&' +
        pp_TxnType +
        '&' +
        pp_ver +
        '&' +
        ppmpf_1;

    var key = utf8.encode(IntegeritySalt);
    var bytes = utf8.encode(superdata);
    var hmacSha256 = Hmac(sha256, key);
    Digest sha256Result = hmacSha256.convert(bytes);

    // Perform payment request
    String url = 'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';
    var response = await http.post(Uri.parse(url),
        body: {
          "pp_Version": pp_ver,
          "pp_TxnType": pp_TxnType,
          "pp_Language": pp_Language,
          "pp_MerchantID": pp_MerchantID,
          "pp_Password": pp_Password,
          "pp_TxnRefNo": tre,
          "pp_Amount": pp_Amount,
          "pp_TxnCurrency": pp_TxnCurrency,
          "pp_TxnDateTime": dateandtime,
          "pp_BillReference": pp_BillReference,
          "pp_Description": pp_Description,
          "pp_TxnExpiryDateTime": dexpiredate,
          "pp_ReturnURL": pp_ReturnURL,
          "pp_SecureHash": sha256Result.toString(),
          "ppmpf_1": ppmpf_1
        });

    // Handle payment response
    print("response=>");
    print(response.body);
    var res = response.body;
    var body = jsonDecode(res);
    responcePrice = body['pp_Amount'];
    Fluttertoast.showToast(msg: "payment successfully ${responcePrice}");

    setState(() {
      isLoading = false;
    });
  }

  // Function to show dialog and collect user details
  Future<void> _showPaymentDialog(BuildContext context) async {
    String accountNo = '';
    String price = '';

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Enter Payment Details',
            style: TextStyle(
              color: Colors.black, // Set the text color to black
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Account Number'),
                onChanged: (value) {
                  accountNo = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                onChanged: (value) {
                  price = value;
                },
              ),
            ],
          ),

    actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                payment(accountNo, price);
                Navigator.of(context).pop();
              },
              child: Text('Pay'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Online Transaction",
          style: TextStyle(
            color: Colors.white, // Set the text color to white
          ),
        ),
        iconTheme: IconThemeData(
            color: Colors.white), // Set the color of the back arrow to white
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/img/signup1.jpg',
              // Replace 'your_image_path_here' with the actual path to your image asset
              fit: BoxFit.cover,
            ),
          ),
          // Centered Button
          Center(
            child: MaterialButton(
              onPressed: () {
                _showPaymentDialog(context);
              },
              child: Text(
                "Click to pay JazzCash",
                style: TextStyle(
                  color: Colors.white,
                  // Add any other styles you need
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}