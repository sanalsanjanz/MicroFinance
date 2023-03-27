// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sacco_management/apis/apiLinks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberLoanController with ChangeNotifier {
  Future showmemberloan({String? unitid, String? memberid}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var map = <String, dynamic>{};
    map['unitid'] = unitid ?? sharedPreferences.getString('unitid');
    map['memberid'] = memberid ?? sharedPreferences.getString('memberid');
    http.Response response = await http.post(AuthLinks.memberloan, body: map);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  Future showMemberBankLoan({String? unitid, String? memberid}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var map = <String, dynamic>{};
    map['unitid'] = unitid ?? sharedPreferences.getString('unitid');
    map['memberid'] = memberid ?? sharedPreferences.getString('memberid');
    http.Response response =
        await http.post(AuthLinks.bankloanpayments, body: map);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  Future showMemberBankLoanBorrows({String? unitid, String? memberid}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var map = <String, dynamic>{};
    map['unitid'] = unitid ?? sharedPreferences.getString('unitid');
    map['memberid'] = memberid ?? sharedPreferences.getString('memberid');
    http.Response response =
        await http.post(AuthLinks.bankloanborrowers, body: map);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  Future showInterest({String? unitid, String? memberid}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var map = <String, dynamic>{};
    map['unitid'] = unitid ?? sharedPreferences.getString('unitid');
    map['memberid'] = memberid ?? sharedPreferences.getString('memberid');
    http.Response response =
        await http.post(AuthLinks.unitintrestpayment, body: map);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  bool intresest = true;
  bool amount = false;
  setinterestclicked() {
    amount = false;
    intresest = true;

    notifyListeners();
  }

  setamountclicked() {
    intresest = false;
    amount = true;

    notifyListeners();
  }

  Future showamountpayment({String? unitid, String? memberid}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var map = <String, dynamic>{};
    map['unitid'] = unitid ?? sharedPreferences.getString('unitid');
    map['memberid'] = memberid ?? sharedPreferences.getString('memberid');
    http.Response response =
        await http.post(AuthLinks.unitloanpayment, body: map);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }
}
