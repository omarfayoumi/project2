import 'package:finalmobileproj/show_players.dart';
import 'package:flutter/material.dart';
import 'ViewFootball.dart';
import 'ViewBasketball.dart';
import 'package:finalmobileproj/AddCategory.dart';


class Buttons extends StatefulWidget {
  const Buttons({super.key});

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buttons"),
        centerTitle: true,
      ),
      body: Center(child: Column(
        children: [
        const SizedBox(height: 20,),
        ElevatedButton(onPressed: (){
          Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ShowCustomersF()),);

        },
          child: const Icon(Icons.sports_soccer, size: 50),
        ),
        const SizedBox(height: 20,)
        ,
          ElevatedButton(onPressed:(){
          Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ShowCustomersB()),);

          },
            child: const Icon(Icons.sports_basketball, size: 50),


          ),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ShowPlayers()),);

        },
          child: const Icon(Icons.person_search, size: 50,),
        ),
          const SizedBox(height: 20,),
          ElevatedButton(onPressed:(){
          Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddPLayer()),);

          },
            child: const Text('Add player'),
          ),
        const SizedBox(height: 20,),
        ElevatedButton(onPressed:(){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddPLayer()),);

        },
          child: const Text('Add player'),
        ),
        ],



        ),
      ),
    );
  }
}
