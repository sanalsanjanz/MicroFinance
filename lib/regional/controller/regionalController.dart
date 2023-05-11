import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sacco_management/apis/apiLinks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegionalController extends ChangeNotifier {
  String regionalName = '';
  String regionalid = '';
  String phone = '';
  String password = '';
  String messagecount = '';
  String passbookno = '';

  getsaved() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    regionalid = preferences.getString('regionalid').toString();
    password = preferences.getString('rpassword').toString();
    regionalName = preferences.getString('rname').toString();
    phone = preferences.getString('rphno').toString();
    passbookno = preferences.getString('rpassbookNo').toString();
    messagecount = preferences.getString('rmessagecount').toString();
    notifyListeners();
  }

  Future getMessages() async {
    var map = <String, dynamic>{};
    map['passbookno'] = passbookno;

    try {
      http.Response response =
          await http.post(AuthLinks.regionGetMessages, body: map);
      if (response.body.contains('regiondata')) {
        var data = jsonDecode(response.body);
        return data;
      } else {}
    } catch (e) {}
    notifyListeners();
  }

  @override
  notifyListeners();
}
