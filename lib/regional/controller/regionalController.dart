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

  Future viewBankLinkage() async {
    var map = <String, dynamic>{};
    map['regionpassbookno'] = passbookno;

    try {
      http.Response response =
          await http.post(AuthLinks.regionalViewBankLinkage, body: map);

      if (response.body.contains('bnkdata')) {
        var data = jsonDecode(response.body);
        return data;
      } else {}
    } catch (e) {}
    notifyListeners();
  }

  Future regionalSessFund() async {
    var map = <String, dynamic>{};
    map['passbookno'] = passbookno;

    try {
      http.Response response =
          await http.post(AuthLinks.regionalSessFund, body: map);

      if (response.body.contains('sdata')) {
        var data = jsonDecode(response.body);
        return data;
      } else {}
    } catch (e) {}
    notifyListeners();
  }

  Future regionalViewSess() async {
    var map = <String, dynamic>{};
    map['regionpassbookno'] = passbookno;

    try {
      http.Response response =
          await http.post(AuthLinks.regionalViewSess, body: map);

      if (response.body.contains('sessdata')) {
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

  List<DropDownValueModel> regionalUnitList = [];

  Future regionalGetUnits() async {
    var map = <String, dynamic>{};
    map['regionpassbookno'] = passbookno;

    try {
      http.Response response =
          await http.post(AuthLinks.regionalGetUnits, body: map);
      if (response.body.contains('bnkdata')) {
        var data = jsonDecode(response.body);
        var length = data[0]['bnkdata'].length;
        for (int i = 0; i < length; i++) {
          regionalUnitList.add(
            DropDownValueModel(
              name: data[0]['bnkdata'][i]['unit'],
              value: data[0]['bnkdata'][i]['passbook_no'],
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
      Fluttertoast.showToast(msg: e.toString());
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future payBankLinkage(
      {required BuildContext context,
      required String loanid,
      required String date}) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['loanid'] = loanid;
    map['date'] = date;
    map['regionpassbookno'] = passbookno;
    try {
      http.Response response =
          await http.post(AuthLinks.regionalPayBankLinkage, body: map);
      if (response.body.contains('Added bank Linkage Payment')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const RegionalHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Added');
      } else if (response.body.contains('Failed to add bank linkage Payment')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to tranfer');
      } else if (response.body
          .contains('There is no bank linkage from unit to pay the center')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'There is no bank linkage from unit');
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

  Future regionalAddBankLinkage({
    required BuildContext context,
    required String amount,
    required String unitPassbook,
    required String period,
    required String pdate,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['regionpassbookno'] = passbookno;
    map['date'] = pdate;
    map['period'] = period;
    map['unitpassbookno'] = unitPassbook;
    try {
      http.Response response =
          await http.post(AuthLinks.regionalAddBankLinkage, body: map);
      if (response.body.contains('Added bank Linkage for the Unit')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const RegionalHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Added');
      } else if (response.body.contains('Insufficient Bank Linkage')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Insufficient Fund');
      } else if (response.body.contains('Failed to add bank linkage')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'There is no bank linkage from unit');
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

  Future regionalTransferSessFund({
    required BuildContext context,
    required String mid,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['passbookno'] = passbookno;
    map['mid'] = mid;

    try {
      http.Response response =
          await http.post(AuthLinks.regionalTransferSess, body: map);
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
        Fluttertoast.showToast(msg: 'Failed');
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

  Future regionalTransferSessFundToUnit({
    required BuildContext context,
    required String sessid,
    required String csdate,
    required String period,
    required String amount,
    required String stdate,
    required String unitpassbookno,
  }) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['regionpassbookno'] = passbookno;
    map['sessid'] = sessid;
    map['csdate'] = csdate;
    map['period'] = period;
    map['amount'] = amount;
    map['stdate'] = stdate;
    map['unitpassbookno'] = unitpassbookno;

    try {
      http.Response response =
          await http.post(AuthLinks.regionalTransferSessToUnit, body: map);
      if (response.body.contains('SESS Fund Transfered')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const RegionalHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Transfered');
      } else if (response.body.contains('SESS Fund transfer failed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed');
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
