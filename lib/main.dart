// @dart=2.9
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nodejs_api_osama/insertProducts.dart';

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
      appBar: AppBar(
        title: Text(' My Products'),
      ),
      body: Center(
          child: FutureBuilder(
              future: getProducts(),
              builder: (context, snapShot) {
                if (snapShot.data != null) {
                  return ListView.builder(
                      itemCount: snapShot.data.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(snapShot.data[index]['name']),
                            subtitle: Text(snapShot.data[index]['desc']),
                            trailing: IconButton(icon: Icon(Icons.delete),
                              onPressed: ()=>confirmDelete(snapShot.data[index]['id']),),
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              })),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => InsertProducts())),
      ),
    );
  }

  confirmDelete(id) {
    showDialog(context: context, builder:(ctx)=>AlertDialog(
      content: Text('Are You Sure'),
      title: Text('Delete'),
      actions: [
        TextButton(onPressed:(){
          http.delete(Uri.parse('https://nameless-savannah-63126.herokuapp.com/products/$id'),);
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Products()));

        } , child: Text('Yes')),
        SizedBox(width: 12,),
        TextButton(onPressed:(){
          Navigator.of(context).pop();
        } , child: Text('No')),

      ],
    ));
  }
}
