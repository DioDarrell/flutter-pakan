import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_pakan/Screens/request.dart';
import 'package:http/http.dart' as http;

class ProductDetails extends StatefulWidget {
  final product_detail_id;
  final product_detail_name;
  final product_detail_price;
  final product_detail_picture;
  final product_detail_desc;

  ProductDetails(
      {this.product_detail_id,
      this.product_detail_name,
      this.product_detail_picture,
      this.product_detail_price,
      this.product_detail_desc});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String url = 'http://si-pakan.herokuapp.com/api/products';

  getProducts() async {
    var response = await http.get(Uri.parse(url));
    //print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('PAKAN'),
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(widget.product_detail_picture),
              ),
              footer: new Container(
                color: Colors.white,
                child: ListTile(
                  leading: new Text(
                    widget.product_detail_name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("${widget.product_detail_price}"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () => Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (context) => ProductRequest(
                        product_detail_id: widget.product_detail_id,
                        product_detail_name: widget.product_detail_name,
                        product_detail_picture: widget.product_detail_picture,
                        product_detail_price: widget.product_detail_price,
                      ),
                    ),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: new Text("Pesan"),
                ),
              ),
            ],
          ),
          new ListTile(
            title: new Text("Description"),
            subtitle: new Text(widget.product_detail_desc),
          ),
        ],
      ),
    );
  }
}
