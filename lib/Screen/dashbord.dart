import 'package:flutter/material.dart';
import 'package:job_tracker/widget/drawer.dart';


class Dashbord extends StatelessWidget {
  const Dashbord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data"),),
      drawer: Drawer(child: AppDrawer(),),
      body: Padding(
        padding:  EdgeInsets.all(16),
          child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text("Welcom Munib", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statCard("Applied", "12"),
                  _statCard("Interviews", "3"),
                  _statCard("Rejected", "5"),
                ],
              )
          ],
        ),
      ),
    );
  }
}

Widget _statCard(String title, String value ){
  return Card(
    child: Padding(padding: EdgeInsets.all(16),
    child: Column(
        children: [
          Text("$value" ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Text("$title"),

      ],
    ),
    ),
  );
}
