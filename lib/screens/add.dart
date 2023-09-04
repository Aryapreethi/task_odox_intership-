import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:samphive/model/person.dart';
import 'package:samphive/screens/view.dart';

class Sample extends StatefulWidget {
  const Sample({super.key});

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  
  Future<void> addata() async{
     final box = await Hive.openBox<Person>('sample'); 
     box.add(Person(name: name.text, age: int.parse(age.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Working with hive"),
        backgroundColor: Colors.orange,
        centerTitle: false,
        leading: Icon(Icons.home),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 200.0, left: 10, right: 10),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "name",
              ),
              // keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
            child: TextField(
              controller: age,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "age",
              ),
              keyboardType: TextInputType.number,
               inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,]
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:80.0,right: 50),
            child: Row(
              children: [
                Padding(
                  padding:  const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFFff7d01),
                      
                    ),
                      onPressed: ()  {
                       
                       addata();
                      Fluttertoast.showToast(msg: 'successfully added',
                      toastLength:  Toast.LENGTH_SHORT,
                      textColor: Colors.black,
                      backgroundColor: Colors.orange);
                   
                      },
                      child: const Text("add",style: TextStyle(color: Colors.black),)),
                ),
                  Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFFff7d01),
                ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const Viewlist())));
                  },
                  child: const Text("view",style: TextStyle(color: Colors.black),)),
            ),
              ],
            ),
          ),
        
        ]),
      ),
    );
  }
}
