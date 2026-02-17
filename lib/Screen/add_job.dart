import 'package:flutter/material.dart';

class AddJob extends StatefulWidget {
  const AddJob({super.key});

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  @override
  Widget build(BuildContext context) {

    final companyController= TextEditingController();
    final positionController= TextEditingController();
    String status="Applied";

    return Scaffold(
      appBar: AppBar(title: Text("Add Job"),),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: companyController,
              decoration: const InputDecoration(labelText: "Company Name"),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
                items: ["Applied","Interview","Offer","Rejected"]
                    .map((e)=> DropdownMenuItem(value: e,
                    child: Text(e),)).toList(),
                    onChanged: (value){
                    setState(() {
                      status= value!;
                    });
                },
                decoration: const InputDecoration(labelText: "Status"),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
                  print("$companyController");
                  print("$positionController");
                  print("$status");
                },
                child: const Text("Save Job"))
          ],
        ),
      ),
    );

  }
}
