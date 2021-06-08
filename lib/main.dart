// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Products(),
  ));
}

class Products extends StatefulWidget {

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var url = 'https://nameless-savannah-63126.herokuapp.com/products';

  getProducts() async {
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
  var jsonOpj = json.decode(res.body);
  return jsonOpj['result'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' My Products'),
      ),
      body: Center(
        child:FutureBuilder(
          future: getProducts(),
          builder: (context ,snapShot) {
            if (snapShot.data != null) {
              return ListView.builder(
                  itemCount: snapShot.data.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(snapShot.data[index]['name']),
                        subtitle: Text(snapShot.data[index]['desc']),

                      ),
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          })
      ),
    );
  }
}
