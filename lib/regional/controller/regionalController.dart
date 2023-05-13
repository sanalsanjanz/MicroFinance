// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sacco_management/apis/apiLinks.dart';
import 'package:sacco_management/regional/view/regionalHome.dart';
import 'package:sacco_management/widgets/progressDialog.dart';
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
          await http.post(AuthLinks.regionalGetMessages, body: map);

      if (response.body.contains('regiondata')) {
        var data = jsonDecode(response.body);
        return data;
      } else {}
    } catch (e) {}
    notifyListeners();
  }

  Future viewGrant() async {
    var map = <String, dynamic>{};
    map['regionpassbookno'] = passbookno;

    try {
      http.Response response =
          await http.post(AuthLinks.regionalViewGrand, body: map);

      if (response.body.contains('grantdata')) {
        var data = jsonDecode(response.body);
        return data;
      } else {}
    } catch (e) {}
    notifyListeners();
  }

  Future viewMedicalAid() async {
    var map = <String, dynamic>{};
    map['passbookno'] = passbookno;

    try {
      http.Response response =
          await http.post(AuthLinks.regionalViewMedicalAid, body: map);

      if (response.body.contains('sdata')) {
        var data = jsonDecode(response.body);
        return data;
      } else {}
    } catch (e) {}
    notifyListeners();
  }

  List<DropDownValueModel> unitList = [];

  Future getUnits(BuildContext context, String grantid) async {
    var map = <String, dynamic>{};
    map['grantid'] = grantid;
    map['regionpassbookno'] = passbookno;

    try {
      http.Response response =
          await http.post(AuthLinks.regionalTranferGrant, body: map);
      if (response.body.contains('unitdata')) {
        var data = jsonDecode(response.body);
        var length = data[1]['unitdata'].length;
        for (int i = 0; i < length; i++) {
          unitList.add(
            DropDownValueModel(
              name: data[1]['unitdata'][i]['unit'],
              value: data[1]['unitdata'][i]['passbook_no'],
            ),
          );
        }
      } else {}
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }

    notifyListeners();
  }

  Future transferGrant({
    required BuildContext context,
    required String grantid,
    required String grantdate,
    required String type,
    required String amount,
    required String transferdate,
    required String unitpassbookno,
  }) async {
    ProgressDialog.show(context: context, status: 'Please wait');

    var map = <String, dynamic>{};
    map['grantid'] = grantid;
    map['regionpassbookno'] = passbookno;
    map['grantdate'] = grantdate;
    map['type'] = type;
    map['amount'] = amount;
    map['transferdate'] = transferdate;
    map['unitpassbookno'] = unitpassbookno;

    try {
      http.Response response =
          await http.post(AuthLinks.regionalTranferGrandToUnit, body: map);
      if (response.body.contains('Grant Transfered')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const RegionalHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Grant Transfered');
      } else if (response.body.contains('Grant transfer failed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to tranfer');
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Something went wrong');
        var data = [];
        return data;
      }
    } catch (e) {
      print(e);
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future transferMedicalAid({
    required BuildContext context,
    required String mid,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['mid'] = mid;
    map['passbookno'] = passbookno;
    try {
      http.Response response =
          await http.post(AuthLinks.regionalTransferMedicalAid, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const RegionalHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Transfered');
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to tranfer');
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } catch (e) {
      print(e);
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future addIndMedicalAid({
    required BuildContext context,
    required String name,
    required String mobile,
    required String place,
    required String amount,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['name'] = name;
    map['mobile'] = mobile;
    map['place'] = place;
    map['amount'] = amount;
    map['passbookno'] = passbookno;
    try {
      http.Response response =
          await http.post(AuthLinks.regionalIndMedicalAid, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const RegionalHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Added');
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to tranfer');
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } catch (e) {
      print(e);
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }
}
