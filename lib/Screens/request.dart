import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_pakan/main.dart';
import 'package:http/http.dart' as http;
//import 'package:toko_pakan/Components/form_req.dart';

class ProductRequest extends StatefulWidget {
  final product_detail_name;
  final product_detail_id;
  final product_detail_price;
  final product_detail_picture;

  ProductRequest(
      {this.product_detail_name,
      this.product_detail_id,
      this.product_detail_picture,
      this.product_detail_price});

  @override
  _ProductRequestState createState() => _ProductRequestState();
}

class _ProductRequestState extends State<ProductRequest> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  Future saveProduct() async {
    final response = await http
        .post(Uri.parse('https://si-pakan.herokuapp.com/api/reqlist'), body: {
      "id_item": widget.product_detail_id.toString(),
      "customer_name": _nameController.text,
      "price": widget.product_detail_price.toString(),
      "phone": _phoneController.text,
      "address": _addressController.text,
      "weight": _selectedWeight.toString(),
      "req_time": _selectedTime.toString(),
      "item_name": widget.product_detail_name.toString(),
    });
   

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    loadTimeList();
    loadWeightList();
    return Scaffold(
      appBar: new AppBar(
        title: Text('Cart'),
        actions: <Widget>[],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Masukkan nama anda";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Masukkan nomor anda";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: "Address"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Masukkan alamat anda";
                }
                return null;
              },
            ),
            DropdownButtonFormField(
              // hint: new Text("Berat"),
              items: weightList,
              value: _selectedWeight,
              onChanged: (value) {
                setState(() {
                  _selectedTime = value;
                });
              },
              isExpanded: true,
              decoration: InputDecoration(labelText: "Weight"),
            ),
            DropdownButtonFormField(
              hint: new Text("Berat"),
              items: timeList,
              value: _selectedTime,
              onChanged: (value) {
                setState(() {
                  _selectedTime = value;
                });
              },
              isExpanded: true,
              decoration: InputDecoration(labelText: "Waktu pemesanan"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  //showAlertDialog(context);
                  saveProduct().then(
                    (value) => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      ),
                    },
                  );
                }
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}

String _selectedTime = "4 Minggu";
String _selectedWeight = "1 Kg";

List<DropdownMenuItem<String>> timeList = [];

void loadTimeList() {
  timeList = [];
  timeList.add(new DropdownMenuItem(
    child: new Text('4 Minggu'),
    value: "4 Minggu",
  ));
  timeList.add(new DropdownMenuItem(
    child: new Text('5 Minggu'),
    value: "5 Minggu",
  ));
  timeList.add(new DropdownMenuItem(
    child: new Text('6 Minggu'),
    value: "6 Minggu",
  ));
  timeList.add(new DropdownMenuItem(
    child: new Text('7 Minggu'),
    value: "7 Minggu",
  ));
  timeList.add(new DropdownMenuItem(
    child: new Text('4 Minggu'),
    value: "8 Minggu",
  ));
}

List<DropdownMenuItem<String>> weightList = [];

void loadWeightList() {
  weightList = [];
  weightList.add(new DropdownMenuItem(
    child: new Text('1 Kg'),
    value: "1 Kg",
  ));
  weightList.add(new DropdownMenuItem(
    child: new Text('2 Kg'),
    value: "2 Kg",
  ));
  weightList.add(new DropdownMenuItem(
    child: new Text('3 Kg'),
    value: "3 Kg",
  ));
  weightList.add(new DropdownMenuItem(
    child: new Text('4 Kg'),
    value: "4 Kg",
  ));
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Tidak"),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductRequest()),
      );
    },
  );
  Widget continueButton = TextButton(
    child: Text("Iya"),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: Text("Apakah anda yakin akan melanjutkan ke pembayaran?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
