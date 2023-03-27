// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sacco_management/apis/apiLinks.dart';
import 'package:sacco_management/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../views/memberHome.dart';

class MemberHomeController with ChangeNotifier {
  String? groupname = 'loading';
  String? memberid = '';
  String? membername = '';
  String? phno = '';
  String? unitname = '';
  String? unitid = '';
  String? unitsid = '';
  String? regionid = '';
  String? passbookno = '';
  String keyword = '';
  String savings = '*****';
  bool viewSavings = false;
  String mothlycollection = '00.00';
  setKeyword(value) {
    keyword = value;
    notifyListeners();
  }

  getDatas() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    memberid = sharedPreferences.getString('memberid');
    membername = sharedPreferences.getString('name');
    phno = sharedPreferences.getString('number');
    groupname = sharedPreferences.getString('unitname');
    unitid = sharedPreferences.getString('unitid');
    unitsid = sharedPreferences.getString('units_id');
    regionid = sharedPreferences.getString('region_id');
    passbookno = sharedPreferences.getString('passbook_no');
    notifyListeners();
  }

  Future searchUnit() async {
    var map = <String, dynamic>{};
    map['uname'] = keyword;
    http.Response response = await http.post(AuthLinks.unitsearch, body: map);
    //print(response.body);
    if (response.body.contains('logdata')) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return null;
    }
  }

  Future sendRequest(BuildContext context, {required String presid}) async {
    var map = <String, dynamic>{};
    map['presidentid'] = presid;
    map['memberid'] = memberid;
    http.Response response = await http.post(AuthLinks.unitrequest, body: map);
    //print(response.body);
    if (response.body.contains('Success')) {
      Fluttertoast.showToast(msg: 'Request sent');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const MemberHome()));
    } else {
      Fluttertoast.showToast(msg: 'Failed to send');
    }
  }

  showsavings() {
    viewSavings = !viewSavings;
    notifyListeners();
  }

  Future getSavings(BuildContext context) async {
    /* 
    DateTime today = DateTime.now();
    var date2 = DateTime(today.year, today.month, today.day - 180);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedend = formatter.format(today);
    final String formattedstart = formatter.format(date2);
 */
    await getDatas();
    var map = <String, dynamic>{};
    map['member'] = memberid; //'39'; //memberid;
    /*  map['memberid'] = '486'; // memberid;
    map['date1'] = formattedstart.toString();
    map['date2'] = formattedend.toString(); */
    http.Response response = await http.post(AuthLinks.getreport, body: map);
    //print(response.body);

    if (response.body.contains('membername')) {
      var data = jsonDecode(response.body);
      //print(data);

      savings = (data[4]['sambadhyamdata']).toString();
      mothlycollection = (data[6]['monthlycollection']).toString();
    } else if (response.body.contains('Empty')) {
      savings = '0';
    } else {
      Fluttertoast.showToast(msg: 'Failed to send');
    }
    notifyListeners();
  }

  dateTimePickerWidget(BuildContext context, int option) {
    return SfDateRangePicker();
  }

  String dateone = '';
  String datetwo = '';
  setdate1(value) {
    dateone = value;
    notifyListeners();
  }

  setDate2(value) {
    datetwo = value;
    notifyListeners();
  }

  Future getReport(
      {required String presid,
      required String date1,
      required String date2}) async {
    var map = <String, dynamic>{};
    map['presidentid'] = unitid;
    map['date1'] = date1;
    map['date2'] = date2;
    try {
      http.Response response = await http.post(AuthLinks.report, body: map);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {}
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection Timeout');
    }
    //print(response.body);
  }

  Future getFestivalFund({required String date1, required String date2}) async {
    var map = <String, dynamic>{};
    map['unitid'] = unitid;
    map['memberid'] = memberid;
    map['date1'] = date1;
    map['date2'] = date2;
    try {
      http.Response response =
          await http.post(AuthLinks.festivalFund, body: map);
      if (response.body.contains('Empty')) {
      } else {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection Timeout');
    }
    //print(response.body);
  }

  Future getSessFund({required String date1, required String date2}) async {
    var map = <String, dynamic>{};
    map['unitid'] = unitid;
    map['memberid'] = memberid;
    map['date1'] = date1;
    map['date2'] = date2;
    try {
      http.Response response = await http.post(AuthLinks.sessFund, body: map);
      if (response.body.contains('Empty')) {
      } else {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection Timeout');
    }
    //print(response.body);
  }

  Future viewSess() async {
    var map = <String, dynamic>{};
    map['passbookno'] = passbookno;
    try {
      http.Response response =
          await http.post(AuthLinks.viewsessfund, body: map);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {}
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection Timeout');
    }
    //print(response.body);
  }

  Future viewgrant() async {
    var map = <String, dynamic>{};
    map['passbookno'] = passbookno; //'70100101'; //passbookno;
    try {
      http.Response response =
          await http.post(AuthLinks.viewMembergrant, body: map);
      if (response.body.contains('Failed')) {
      } else {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection Timeout');
    }
    //print(response.body);
  }

  Future memberBankLinkage() async {
    var map = <String, dynamic>{};
    map['passbookno'] = passbookno;
    //'70100102';
    try {
      http.Response response =
          await http.post(AuthLinks.memberBanklinkage, body: map);
      if (response.body.contains('Failed')) {
        Fluttertoast.showToast(
          msg: 'No Bank Linkage',
          gravity: ToastGravity.CENTER,
        );
      } else {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection Timeout');
    }
    //print(response.body);
  }

  Future viewInsurance({required String date1, required String date2}) async {
    var map = <String, dynamic>{};
    map['memberid'] = memberid; //115
    map['date1'] = date1;
    map['date2'] = date2;

    try {
      http.Response response =
          await http.post(AuthLinks.membinsurance, body: map);
      if (response.body.contains('empty')) {
      } else {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection Timeout');
    }
    //print(response.body);
  }

  Future getMembers() async {
    var map = <String, dynamic>{};
    map['unitid'] = unitid;
    //'70100102';
    try {
      http.Response response =
          await http.post(AuthLinks.memberMlist, body: map);
      if (response.body.contains('Empty')) {
        Fluttertoast.showToast(
          msg: 'No members',
          gravity: ToastGravity.CENTER,
        );
      } else {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection Timeout');
    }
    //print(response.body);
  }

  Future getMothlyCollection(
      {required String date1, required String date2}) async {
    var map = <String, dynamic>{};
    map['unitid'] = unitid;
    map['memberid'] = memberid;
    map['date1'] = date1;
    map['date2'] = date2;
    //'70100102';
    try {
      http.Response response =
          await http.post(AuthLinks.memberMonthlyCollection, body: map);
      if (response.body.contains('Empty')) {
        Fluttertoast.showToast(
          msg: 'No Collection',
          gravity: ToastGravity.CENTER,
        );
      } else {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection Timeout');
    }
  }

  Future getExpense({required String date1, required String date2}) async {
    var map = <String, dynamic>{};
    map['unitid'] = unitid;
    // map['memberid'] = memberid;
    map['date1'] = date1;
    map['date2'] = date2;
    //'70100102';
    try {
      http.Response response =
          await http.post(AuthLinks.memberMExpense, body: map);
      if (response.body.contains('empty')) {
        Fluttertoast.showToast(
          msg: 'No Collection',
          gravity: ToastGravity.CENTER,
        );
      } else {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection Timeout');
    }
  }

  Future getAttendance({required String date1, required String date2}) async {
    var map = <String, dynamic>{};
    map['unitid'] = unitid;
    map['memberid'] = memberid;
    map['date1'] = date1;
    map['date2'] = date2;
    //'70100102';
    try {
      http.Response response =
          await http.post(AuthLinks.memberMAttendance, body: map);
      if (response.body.contains('Empty')) {
        Fluttertoast.showToast(
          msg: 'No Collection',
          gravity: ToastGravity.CENTER,
        );
      } else {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Connection Timeout');
    }
  }

  meberLogout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Fluttertoast.showToast(msg: 'Yahooo !!!');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => const SplashScreen(),
        ),
        (route) => false);
  }

  /*  Container(
                                  // color: primaryUnitColor,
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Do you want to Logout ?'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('NO'),
                                          ),
                                          const VerticalDivider(),
                                          TextButton(
                                            onPressed: () async {
                                              await value.meberLogout(context);
                                            },
                                            child: const Text('YES'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ), */
}
