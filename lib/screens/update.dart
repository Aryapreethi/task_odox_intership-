import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:samphive/model/person.dart';
import 'package:samphive/screens/view.dart';

class Updatedata extends StatefulWidget {
  final int? index;
  final Person? person;
  final String updatename;
  final int updateage;
  const Updatedata(
    {super.key, this.index, this.person, required this.updatename, required this.updateage});

  @override
  State<Updatedata> createState() => _UpdatedataState();
}

class _UpdatedataState extends State<Updatedata> {
  late Box<Person> data;
  late final TextEditingController updatename;
  late final TextEditingController updateage;

  @override
  void initState() {
    super.initState();
    data = Hive.box('sample');
    updatename = TextEditingController(text: widget.updatename);
    updateage = TextEditingController(text: widget.updateage.toString());
  }

 void update() {
    Person samp =
        Person(name: updatename.text, age: int.parse(updateage.text));
    data.putAt(widget.index!, samp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("update data"),
        backgroundColor: Colors.orange[200],
          leading: IconButton(onPressed:(){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: ((context) => const Viewlist())));
        },icon:const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200.0, left: 20, right: 20),
              child: TextField(
                controller: updatename,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
              child: TextField(
                controller: updateage,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  update();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const Viewlist())));
                },
                child: const Text("submit"))
          ],
        ),
      ),
    );
  }
}
