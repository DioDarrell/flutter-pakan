import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_pakan/Screens/product_details.dart';
import 'package:http/http.dart' as http;

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  String url = 'http://si-pakan.herokuapp.com/api/products';

  getProducts() async {
    var response = await http.get(Uri.parse(url));
    //print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    //getProducts();
    return FutureBuilder(
      future: getProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
              itemCount: snapshot.data['data'].length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, index) {
                return Single_prod(
                  prod_id: snapshot.data['data'][index]['id'],
                  prod_name: snapshot.data['data'][index]['name'],
                  prod_picture: snapshot.data['data'][index]['image_url'],
                  prod_price: snapshot.data['data'][index]['price'],
                  prod_desc: snapshot.data['data'][index]['description'],
                );
              });
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class Single_prod extends StatelessWidget {
  final prod_id;
  final prod_name;
  final prod_picture;
  final prod_price;
  final prod_desc;

  Single_prod({
    this.prod_id,
    this.prod_name,
    this.prod_picture,
    this.prod_price,
    this.prod_desc,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: prod_name,
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context) => ProductDetails(
                  product_detail_id: prod_id,
                  product_detail_name: prod_name,
                  product_detail_picture: prod_picture,
                  product_detail_price: prod_price,
                  product_detail_desc: prod_desc,
                ),
              ),
            ),
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    prod_name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Text("Rp $prod_price"),
                ),
              ),
              child: Image.network(
                prod_picture,
                fit: BoxFit.cover,
              ),
              // child: Container(

              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       fit: BoxFit.cover,
              //       image: NetworkImage(prod_picture),
              //     ),
              //   ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
