import 'package:flutter/material.dart';
import 'package:toko_pakan/Components/products.dart';
import 'package:toko_pakan/Screens/request.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('PAKAN'),
      ),
      body: Container(
        child: Products(),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //header
            new UserAccountsDrawerHeader(
              accountName: Text('Reku'),
              accountEmail: Text('1931710173@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(backgroundColor: Colors.grey),
              ),
            ),
            //body drawer
            
          ],
        ),
      ),
    );
  }
}
