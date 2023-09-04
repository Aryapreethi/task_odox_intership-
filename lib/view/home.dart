import 'package:apicallprovider/provider/getdatapro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController text = TextEditingController();
  @override
  void initState() {
    super.initState();
    final postProvider =
        Provider.of<GetdetailsProvider>(context, listen: false);
    postProvider.getData();
  }

  @override
  Widget build(BuildContext context) {
    // final provider =Provider.of<GetdetailsProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chat',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '127 online',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.edit, color: Color(0XFF8c94a2)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.settings, color: Color(0XFF8c94a2)),
          )
        ],
      ),
      body: Consumer<GetdetailsProvider>(
        builder: (context, value, child) {
          final getdetails = value.getdata;
          return Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    color: const Color(0XFFedf0f5),
                    child: TextField(
                      controller: text,
                      onChanged: (word) {
                        var provider = Provider.of<GetdetailsProvider>(context,
                            listen: false);
                        setState(() {
                          provider.searchItems(word);
                        });
                      },
                      decoration: const InputDecoration(
                          hintText: "Search",
                          prefixIcon:
                              Icon(Icons.search, color: Color(0XFF8c94a2)),
                          border: InputBorder.none),
                    ),
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: ListView.builder(
                    itemCount: getdetails.length,
                    itemBuilder: (context, index) {
                      final userdetails = getdetails[index];
                      //  var searchResults = provider.getdata;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(userdetails.avatar),
                        ),
                        title: Text(
                            '${userdetails.firstName} ${userdetails.lastName}'),
                        subtitle: Text(
                          userdetails.email,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
