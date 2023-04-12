// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sacco_management/apis/apiLinks.dart';
import 'package:sacco_management/unit/views/unitHome.dart';
import 'package:sacco_management/widgets/progressDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UnitControll extends ChangeNotifier {
  String? unitName = '';
  String? unitId = '';
  String? phoneNumber = '';
  String? messageCount = '';
  String? messages = '';
  String? password = '';
  String? passbookNo = '';

  void getdatas() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    unitName = sharedPreferences.getString('unit');
    passbookNo = sharedPreferences.getString('passbookNo');
    unitId = sharedPreferences.getString('unitId');
    password = sharedPreferences.getString('password');
    phoneNumber = sharedPreferences.getString('phone');
    messageCount = sharedPreferences.getString('messagecount');
    messages = sharedPreferences.getString('messages');
    notifyListeners();
  }

  Future getDataa() async {
    var map = <String, dynamic>{};
    map['mobile'] = phoneNumber; //phone;
    map['password'] = password; // password;

    try {
      http.Response response = await http.post(AuthLinks.signinunit, body: map);
      if (response.body.contains('Success')) {
        var data = jsonDecode(response.body);
        return data;
        // return result;
      } else if (response.body.contains('invalid password')) {
      } else {}
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection Timeout');
    }
    notifyListeners();
  }

  List<DropDownValueModel> accountingHeadExpense = [];
  List<DropDownValueModel> accountingHeadIncome = [];
  Future getAccountingHead({required String type}) async {
    var map = <String, dynamic>{};

    map['passbookno'] = passbookNo;

    try {
      http.Response response =
          await http.post(AuthLinks.getUnitaccountinghead, body: map);
      if (response.body.contains('incomedata')) {
        var data = jsonDecode(response.body);
        if (type == 'income') {
          var length = data[1]['incomedata'].length;
          for (int i = 0; i < length; i++) {
            accountingHeadIncome.add(DropDownValueModel(
                name: data[1]['incomedata'][i]['head'],
                value: data[1]['incomedata'][i]['head']));
          }
        } else if (type == 'expense') {
          var length = data[0]['expensedata'].length;
          for (int i = 0; i < length; i++) {
            accountingHeadExpense.add(DropDownValueModel(
                name: data[0]['expensedata'][i]['head'],
                value: data[0]['expensedata'][i]['head']));
          }
        }
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future addIncome(
      {required String type,
      required BuildContext context,
      required String date,
      required String amount,
      required String accountinghead}) async {
    ProgressDialog.show(context: context, status: 'Adding Income');

    var map = <String, dynamic>{};

    map['accountinghead'] = accountinghead; // password;
    map['incometype'] = type; // password;
    map['amount'] = amount; // password;
    map['date'] = date; // password;
    map['passbookno'] = passbookNo; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.addotherincome, body: map);
      if (response.body.contains('success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Income added successfully');
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to Add');
      }
    } catch (e) {
      ProgressDialog.hide(context);
      Fluttertoast.showToast(msg: e.toString());

      print(e);
    }
    notifyListeners();
  }

  Future addExpense(
      {required String type,
      required BuildContext context,
      required String date,
      required String amount,
      required String accountinghead}) async {
    ProgressDialog.show(context: context, status: 'Adding Expense');

    var map = <String, dynamic>{};

    map['accountinghead'] = accountinghead; // password;
    map['reason'] = type; // password;
    map['amount'] = amount; // password;
    map['date'] = date; // password;
    map['passbookno'] = passbookNo; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.unitaddexpense, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Expense added successfully');
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to Add');
      }
    } catch (e) {
      ProgressDialog.hide(context);
      Fluttertoast.showToast(msg: e.toString());

      print(e);
    }
    notifyListeners();
  }

  List<DropDownValueModel> shglist = [];

  Future getallSHG({
    required BuildContext context,
  }) async {
    var map = <String, dynamic>{};

    map['passbookno'] = passbookNo; // password;
    map['unitid'] = unitId; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.getAllshgUnit, body: map);
      if (response.body.contains('sdata')) {
        var data = jsonDecode(response.body);

        var length = data[0]['sdata'].length;
        for (int i = 0; i < length; i++) {
          // print(data[0]['memberdata'][i]);
          shglist.add(DropDownValueModel(
              name: data[0]['sdata'][i]['shgname'],
              value: data[0]['sdata'][i]['passbookno']));
        }
        return data;
      } else {
        var data = [];
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    notifyListeners();
  }

  String unitsessAmount = '0';
  Future tranfersesstoShg({
    required BuildContext context,
    required String shgPassbookno,
  }) async {
    var map = <String, dynamic>{};

    map['shgpassbookno'] = shgPassbookno;
    map['unitpassbookno'] = passbookNo;

    try {
      http.Response response =
          await http.post(AuthLinks.shgsessfundtransferRegion, body: map);
      if (response.body.contains('sdata')) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        var data = [];
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    notifyListeners();
  }

  Future unitViewSessFund({required BuildContext context}) async {
    var map = <String, dynamic>{};
    map['unitpassbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitViewSessFund, body: map);
      if (response.body.contains('sessdata')) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        var data = [];
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    notifyListeners();
  }

  Future fetchtotalSess() async {
    var map = <String, dynamic>{};
    map['unitpassbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitFetchSessTotal, body: map);
      if (response.body.contains('datas')) {
        var data = jsonDecode(response.body);
        unitsessAmount = data[0]['totalamt'].toString();
        notifyListeners();
      } else {}
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    notifyListeners();
  }

  Future unitTransferSesstoShg(
      {required BuildContext context,
      required String sessid,
      required String amount,
      required String sessfunddate,
      required String shgpassbookno,
      required String transferdate,
      required String period}) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Please wait');

    map['sessid'] = sessid;
    map['transferdate'] = transferdate;
    map['period'] = period;
    map['amount'] = amount;
    map['sessfunddate'] = sessfunddate;
    map['shgpassbookno'] = shgpassbookno;
    map['unitpassbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.transfersessfundunit, body: map);
      if (response.body.contains('SESSFund Transfered')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Transfered');
      } else {
        ProgressDialog.hide(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Failed');
      }
    } catch (e) {
      ProgressDialog.hide(context);

      Fluttertoast.showToast(msg: e.toString());
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future unittransferSesstoRegion(
      {required BuildContext context, required String sessid}) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Please wait');

    map['mid'] = sessid;
    map['unitpassbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitsessfundtransferRegion, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Transfered');
      } else {
        ProgressDialog.hide(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Failed');
      }
    } catch (e) {
      ProgressDialog.hide(context);

      Fluttertoast.showToast(msg: e.toString());
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future unitPaySessFund(
      {required BuildContext context, required String sessid}) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Please wait');

    map['mid'] = sessid;
    map['unitpassbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitpaySessFund, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Transfered');
      } else {
        ProgressDialog.hide(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Failed');
      }
    } catch (e) {
      ProgressDialog.hide(context);

      Fluttertoast.showToast(msg: e.toString());
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }
}
