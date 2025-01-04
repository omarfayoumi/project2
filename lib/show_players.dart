//osman askar
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

final List<String> _customers = [];

const String _baseURL = 'fdb1029.awardspace.net';

class ShowPlayers extends StatefulWidget {
  const ShowPlayers({super.key});

  @override
  State<ShowPlayers> createState() => _ShowCustomersState();
}

class _ShowCustomersState extends State<ShowPlayers> {
  bool _load = false;

  void update(bool success) {
    setState(() {
      _load = true;
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }


  @override
  void initState() {

    updateCustomers(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Available Players'),
          centerTitle: true,
        ),
        body: _load ? const ListCustomers() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
        )
    );
  }
}

class ListCustomers extends StatelessWidget {
  const ListCustomers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _customers.length,
        itemBuilder: (context, index) => Column(children: [
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Flexible(child: Text(_customers[index], style: TextStyle(fontSize: 18)))
          ])
        ])
    );
  }
}

void updateCustomers(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'json.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5));
    _customers.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        _customers.add('pid: ${row['pid']} name: ${row['name']} age: ${['age']} category: ${row['category']} ');
      }
      update(true);
    }
  }
  catch(e) {
    update(false);
  }
}

