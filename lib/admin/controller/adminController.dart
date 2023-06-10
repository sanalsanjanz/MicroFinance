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
  List<DropDownValueModel> regionalList2 = [];
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
        return data;
      } else {}
    } catch (e) {}
    notifyListeners();
  }

  int sessAmount = 0;
  Future getSessDetails() async {
    try {
      http.Response response = await http.get(AuthLinks.adminGetSessAmount);
      if (response.body.contains('sdata')) {
        var data = jsonDecode(response.body);
        sessAmount = data[0]['tdata'];
        var length = data[0]['sdata'].length;
        for (int i = 0; i < length; i++) {
          regionalList2.add(DropDownValueModel(
              name: data[0]['sdata'][i]['region'],
              value: data[0]['sdata'][i]['passbookno']));
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

  Future addBankLinkage({
    required BuildContext context,
    required String regionpassbookno,
    required String period,
    required String date,
    required String amount,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};

    map['regionpassbookno'] = regionpassbookno;
    map['period'] = period;
    map['amount'] = amount;
    map['adminid'] = id;
    map['date'] = date;

    try {
      http.Response response =
          await http.post(AuthLinks.adminAddBankLinkage, body: map);
      if (response.body.contains('Added bank Linkage for the Region')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const AdminHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Bank Linkage Added');
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to add');
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

  Future addSessFund({
    required BuildContext context,
    required String regionpassbookno,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};

    map['regionpassbookno'] = regionpassbookno;

    map['adminid'] = id;

    try {
      http.Response response =
          await http.post(AuthLinks.adminAddSessFund, body: map);
      if (response.body.contains('Added sessfund for the Region')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const AdminHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Sess Fund Added');
      } else if (response.body.contains('Insufficient SESS Fund')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Insufficient SESS Fund');
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

  List<DropDownValueModel> income = [];
  List<DropDownValueModel> expense = [];
  Future getAccountingHead(String? type) async {
    try {
      http.Response response = await http.get(AuthLinks.adminGetAccountingHead);
      if (response.body.contains('expensedata') ||
          response.body.contains('incomedata')) {
        var data = jsonDecode(response.body);
        if (type != '') {
          if (type == 'expense') {
            var length = data[0]['expensedata'].length;
            for (int i = 0; i < length; i++) {
              // //print(data[0]['memberdata'][i]);
              expense.add(DropDownValueModel(
                  name: data[0]['expensedata'][i]['head'],
                  value: data[0]['expensedata'][i]['head']));
            }
            notifyListeners();
          } else if (type == 'income') {
            var length = data[1]['incomedata'].length;
            for (int i = 0; i < length; i++) {
              // //print(data[0]['memberdata'][i]);
              income.add(DropDownValueModel(
                  name: data[1]['incomedata'][i]['head'],
                  value: data[1]['incomedata'][i]['head']));
            }
            notifyListeners();
          }
        } else {
          return data;
        }

        return data;
        // return result;
      } else {
        var data = [
          {'message': 'no datas'}
        ];
        return data;
      }
    } catch (e) {
      //print(e);
    }
    notifyListeners();
  }

  Future addOtherIncome({
    required BuildContext context,
    required String amount,
    required String date,
    required String type,
    required String accountinghead,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['accountinghead'] = accountinghead;
    map['type'] = type;
    map['date'] = date;
    map['adminid'] = id;
    map['amount'] = amount;

    try {
      http.Response response =
          await http.post(AuthLinks.adminAddIncome, body: map);
      if (response.body.contains('Income added')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const AdminHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Income added');
      } else if (response.body.contains('Income adding failed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed');
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

  Future addExpense({
    required BuildContext context,
    required String amount,
    required String date,
    required String reason,
    required String accountinghead,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['accountinghead'] = accountinghead;
    map['reason'] = reason;
    map['date'] = date;
    map['adminid'] = id;
    map['amount'] = amount;

    try {
      http.Response response =
          await http.post(AuthLinks.adminAddExpense, body: map);
      if (response.body.contains('Expense is added successfully')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const AdminHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Expense added');
      } else if (response.body.contains('Failed to add Expense')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed');
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

  Future addRegional({
    required BuildContext context,
    required String name,
    required String number,
    required String password,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['regionname'] = name;
    map['mobile'] = number;
    map['password'] = password;
    map['adminid'] = id;

    try {
      http.Response response =
          await http.post(AuthLinks.adminAddRegional, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const AdminHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: '$name added');
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to add $name');
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

  Future addUnit({
    required BuildContext context,
    required String name,
    required String number,
    required String password,
    required String passbookno,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['unitname'] = name;
    map['regionpassbookno'] = passbookno;
    map['mobile'] = number;
    map['password'] = password;
    map['adminid'] = id;

    try {
      http.Response response =
          await http.post(AuthLinks.adminAddUnit, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const AdminHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: '$name added');
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to add $name');
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

  Future addAccountingHead(
      BuildContext context, String? type, String? accountinghead) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['accountinghead'] = accountinghead;
    map['type'] = type;

    try {
      http.Response response =
          await http.post(AuthLinks.adminAddAccountingHead, body: map);
      if (response.body.contains('Accounting head added')) {
        Fluttertoast.showToast(msg: 'successfully added');
        await getAccountingHead('');
        ProgressDialog.hide(context);
        /*  Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const SplashScreen(),
            ),
            (route) => false); */
      } else if (response.body
          .contains('Already added this accounting head before')) {
        Fluttertoast.showToast(msg: 'Already exist');

        ProgressDialog.hide(context);
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      ProgressDialog.hide(context);
      //print(e);
    }
    notifyListeners();
  }
}
