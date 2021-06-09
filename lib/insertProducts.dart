import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsertProducts extends StatefulWidget {
  @override
  _InsertProductsState createState() => _InsertProductsState();
}

class _InsertProductsState extends State<InsertProducts> {
  var formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var desc = TextEditingController();

  insertP()async{
    var res = await http.post(Uri.parse('https://nameless-savannah-63126.herokuapp.com/products'),
    body: {
      "name": name.text,
      "desc":desc.text,
    },
    // headers:{
    //   "Content-Type":"application/x-www-form-urlencoded"
    // }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Products'),
      ),
      body: Center(
          child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: name,
                validator: (val) {
                  if (val == null) {
                    return 'plz enter name';
                  }
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: desc,
                validator: (val) {
                  if (val == null) {
                    return 'plz enter desc';
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: insertP,
                child: Text('Insert'),
              )
            ],
          ),
        ),
      )),
    );
  }
}
