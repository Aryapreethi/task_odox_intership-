import 'dart:convert';
import 'package:apicallprovider/model/details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class GetdetailsProvider extends ChangeNotifier {
  List<Details> _items = [];
  List<Details> get getdata => _items;

  Future<void> getData() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=1'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> userlist = json.decode(response.body);
      final List<dynamic> data = userlist['data'];
      _items = data
          .map((e) => Details(
              id: e['id'],
              email: e['email'],
              firstName: e['first_name'],
              lastName: e['last_name'],
              avatar: e['avatar']))
          .toList();
      notifyListeners();
    } else {
      throw Exception('somthing went wrong');
    }
  }

  search(String word) {
      _items = getdata
          .where((element) =>
              element.firstName.toLowerCase().contains(word.toLowerCase()) ||
              element.lastName.toLowerCase().contains(word.toLowerCase()) ||
              element.email.toLowerCase().contains(word.toLowerCase()))
          .toList();
    notifyListeners();
    
  }

 searchItems(String val) async {
     await getData();
     search(val);
    notifyListeners();
  }
}
