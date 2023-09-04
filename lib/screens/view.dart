import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:samphive/model/person.dart';
import 'package:samphive/screens/add.dart';
import 'package:samphive/screens/update.dart';

class Viewlist extends StatefulWidget {

  const Viewlist({super.key});
  

  @override
  State<Viewlist> createState() => _ViewlistState();
}

class _ViewlistState extends State<Viewlist> {

    late Box<Person> box;
  @override
  void initState() {
    getbox();
    super.initState();
  }

  Future<void> getbox()  async {
    box =  Hive.box('sample');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View data"),
        backgroundColor: Colors.orange[200],
        leading: IconButton(onPressed:(){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: ((context) => const Sample())));
        },icon:const Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
        itemCount: box.length,
        itemBuilder: (context, index) {
          Person pp = box.getAt(index)!;
          return ListTile(
            trailing: IconButton(
             onPressed: () {
               Navigator.push(context,MaterialPageRoute(builder: ((context) => Updatedata(
                index: index,
                person: pp,
                updatename: pp.name,
                updateage: pp.age))));
             },
             icon: const Icon(Icons.edit),
                ),
                leading:   IconButton(
                  onPressed: () {
                    setState(() {
                      box.deleteAt(index);
                    });
                  },
                  icon: const Icon(Icons.delete),
                ),
            title: Text(pp.name),
            subtitle: Text(pp.age.toString()),
          );
        },
      ),
    );
  }
}
