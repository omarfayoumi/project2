import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'buttons.dart';

import 'home.dart';


const String _baseURL = 'fdb1029.awardspace.net';

class AddPLayer extends StatefulWidget {
  const AddPLayer({super.key});

  @override
  State<AddPLayer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddPLayer> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();
  TextEditingController _controllerCid = TextEditingController();
 
  bool _loading = false;


  @override
  void dispose() {
    _controllerName.dispose();
    _controllerAge.dispose();
    _controllerCid.dispose();
    super.dispose();
  }
  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Customer'),
          centerTitle: true,
        
          automaticallyImplyLeading: false,
        ),
        body: Center(child: Form(
          key: _formKey, 
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Name';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerAge,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Age',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Age';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerCid,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Cid',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Cid';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              ElevatedButton(
                // we need to prevent the user from sending another request, while current
                // request is being processed
                onPressed: _loading ? null : () { // disable button while loading
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loading = true;
                    });
                    saveCustomer(update, _controllerName.text, int.parse(_controllerAge.text),
                        int.parse(_controllerCid.text));
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Buttons()));
                },
                child: const Text('Home'),
              ),
              const SizedBox(height: 10),
              const Text("Cid 1 = Basketball"),
              const Text("Cid 2 = Football"),
              const SizedBox(height: 10),
              Visibility(visible: _loading, child: const CircularProgressIndicator())
            ],
          ),
        )));
  }
}

void saveCustomer(Function(String text) update, String Name, int Age, int Cid) async {
  try {
    // we need to first retrieve and decrypt the key
    // send a JSON object using http post
    final response = await http.post(
        Uri.parse('$_baseURL/saveCustomer.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }, 
        body: convert.jsonEncode(<String, String>{
          'name': '$Name', 'Age': '$Age', 'Cid':'$Cid', 'key': 'your_key'
        })).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      // if successful, call the update function
      update(response.body);
    }
  }
  catch(e) {
    update(e.toString());
  }
}

