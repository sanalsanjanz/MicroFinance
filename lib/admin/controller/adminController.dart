// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sacco_management/admin/view/adminHome.dart';
import 'package:sacco_management/apis/apiLinks.dart';
import 'package:sacco_management/widgets/progressDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AdminController extends ChangeNotifier {
  String? id = '';
  String? name = '';
  String? phone = '';
  String? password = '';
  getSavedInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    id = sharedPreferences.getString('adminId');
    name = sharedPreferences.getString('adminName');
    phone = sharedPreferences.getString('adminPhone');
    password = sharedPreferences.getString('adminPassword');
    notifyListeners();
  }

  Future addMedicalAid({
    required BuildContext context,
    required String name,
    required String place,
    required String mobile,
    required String amount,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['name'] = name;
    map['mobile'] = mobile;
    map['place'] = place;
    map['adminid'] = id;
    map['amount'] = amount;

    try {
      http.Response response =
          await http.post(AuthLinks.adminAddMedicalAid, body: map);
      if (response.body.contains('Added Medical Aid for the Individual')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const AdminHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Added Medical Aid');
      } else if (response.body.contains('Insufficient Medical Aid')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Insufficient Medical Aid');
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } catch (e) {
      //print(e);
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  List<DropDownValueModel> regionalList = [];
  Future getAllRegionalList() async {
    try {
      http.Response response = await http.get(AuthLinks.adminAllRegions);
      if (response.body.contains('regiondata')) {
        var data = jsonDecode(response.body);
        var length = data[0]['regiondata'].length;
        for (int i = 0; i < length; i++) {
          regionalList.add(DropDownValueModel(
              name: data[0]['regiondata'][i]['region'],
              value: data[0]['regiondata'][i]['passbook_no']));
        }
        notifyListeners();
      } else {}
    } catch (e) {}
    notifyListeners();
  }

  Future addGrant({
    required BuildContext context,
    required String regionpassbookno,
    required String type,
    required String date,
    required String amount,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['regionpassbookno'] = regionpassbookno;
    map['type'] = type;
    map['amount'] = amount;
    map['adminid'] = id;
    map['date'] = date;

    try {
      http.Response response =
          await http.post(AuthLinks.adminAddGrant, body: map);
      if (response.body.contains('Grant Added')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const AdminHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Grant Added');
      } else if (response.body.contains('Failed to add Grant')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to add Grant');
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } catch (e) {
      //print(e);
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }
}
