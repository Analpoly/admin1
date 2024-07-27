import 'package:admin1/contextpg.dart';
import 'package:admin1/offerspg.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> OffersPage()));
            }, child: Text("Offers")),
            SizedBox(height: 15,),
            ElevatedButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> Contextpg()));
            }, child: Text("context")),

          ],
        ),
      ),
    );
  }
}
