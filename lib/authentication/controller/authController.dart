// ignore_for_file: avoid_print, file_names, use_build_context_synchronously, unused_local_variable

import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart ' as http;
import 'package:sacco_management/admin/view/adminHome.dart';
import 'package:sacco_management/apis/apiLinks.dart';
import 'package:sacco_management/authentication/views/authentication.dart';
import 'package:sacco_management/member/views/memberHome.dart';
import 'package:sacco_management/president/view/presidenthome.dart';
import 'package:sacco_management/regional/view/regionalHome.dart';
import 'package:sacco_management/unit/views/unitHome.dart';
import 'package:sacco_management/widgets/progressDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  void userStatus(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('login', value);
    notifyListeners();
  }

  bool agree = true;
  bool shg = false;

  bool unit = false;
  bool member = false;
  bool existingUser = false;
  bool newuser = false;
  bool obsurePass = true;
  String username = '';
  String phone = '';
  String password = '';
  String place = '';
  bool regional = false;
  bool head = false;
  setsuername(value) {
    username = value;
    notifyListeners();
  }

  setPlace(value) {
    place = value;
    notifyListeners();
  }

  setagree(value) {
    agree = value;
    notifyListeners();
  }

  setphonenumber(value) {
    phone = value;
    notifyListeners();
  }

  setPassword(value) {
    password = value;
    notifyListeners();
  }

  viewPass() {
    obsurePass = !obsurePass;
    notifyListeners();
  }

  setexisting() {
    existingUser = true;
    newuser = false;
    notifyListeners();
  }

  setnewUser() {
    newuser = true;
    existingUser = false;
    notifyListeners();
  }

  chooseShg() {
    shg = true;
    unit = false;
    member = false;
    head = false;
    regional = false;
    notifyListeners();
  }

  chooseMember() {
    shg = false;
    member = true;
    unit = false;
    regional = false;
    head = false;
    notifyListeners();
  }

  chooseUnit() {
    shg = false;
    member = false;
    unit = true;
    head = false;
    regional = false;
    notifyListeners();
  }

  chooseRegional() {
    shg = false;
    member = false;
    unit = false;
    head = false;
    regional = true;
    notifyListeners();
  }

  chooseHead() {
    shg = false;
    member = false;
    unit = false;
    head = true;
    regional = false;
    notifyListeners();
  }

  Future login(BuildContext context) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['uphone'] = phone;
    map['password'] = password;

    try {
      http.Response response =
          await http.post(AuthLinks.memberlogin, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        userStatus('member');
        var data = await jsonDecode(response.body);
        await saveLogin(data);
        // print(response.body);
        Fluttertoast.showToast(msg: 'Success');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const MemberHome()),
            (route) => false);
      } else if (response.body.contains('invalid password')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Incorrect password');
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed');
      }
    } catch (e) {
      print(e);
    }
    ProgressDialog.hide(context);
  }

  Future singinRegional(BuildContext context) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['mobile'] = phone;
    map['password'] = password;

    try {
      http.Response response =
          await http.post(AuthLinks.signinRegional, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        userStatus('reginal');
        List<dynamic> data = await jsonDecode(response.body);
        // await saveLogin(data);
        // print(response.body);
        await saveRegionalLogin(value: data);
        Fluttertoast.showToast(msg: 'Success');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const RegionalHome()),
            (route) => false);
      } else if (response.body.contains('invalid password')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Incorrect password');
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed');
      }
    } catch (e) {
      print(e);
    }
    ProgressDialog.hide(context);
  }

  Future singinAdmin(BuildContext context) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['mobile'] = phone;
    map['password'] = password;

    try {
      http.Response response =
          await http.post(AuthLinks.signinAdmin, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        userStatus('admin');
        List<dynamic> data = await jsonDecode(response.body);

        await saveAdminLogin(value: data).then((value) => Navigator.of(context)
            .pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const AdminHome()),
                (route) => false));
        Fluttertoast.showToast(msg: 'Success');
      } else if (response.body.contains('invalid password')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Incorrect password');
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed');
      }
    } catch (e) {
      print(e);
    }
    ProgressDialog.hide(context);
  }

  Future loginpresident(BuildContext context) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['uphone'] = phone; //'9995959595'; //phone;
    map['password'] = password; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.signinpresident, body: map);
      if (response.body.contains('Success')) {
        userStatus('group');
        List<dynamic> data = jsonDecode(response.body);
        await savePresidentDetails(value: data);
        Fluttertoast.showToast(msg: 'Success');
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const PresidentHome()),
            (route) => false);
        // return result;
      } else if (response.body.contains('invalid password')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Incorrect password');
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed');
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future signupMember(BuildContext context) async {
    ProgressDialog.show(context: context, status: 'Please Wait');

    var map = <String, dynamic>{};
    map['regionid'] = '1';
    map['unitid'] = '1';
    map['uphone'] = phone;
    map['password'] = password;
    map['umailid'] = username; //name
    try {
      http.Response response =
          await http.post(AuthLinks.signupmember, body: map);
      // print(response.body);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(
          msg: 'Registration success',
        );
      } else {
        ProgressDialog.hide(context);

        Fluttertoast.showToast(msg: 'Try again');
      }
    } catch (e) {
      print(e);
      ProgressDialog.hide(context);
    }
    ProgressDialog.hide(context);
  }

  Future changememberpassword(BuildContext context) async {
    var map = <String, dynamic>{};
    map['uid'] = phone;
    map['password'] = password;
    try {
      http.Response response =
          await http.post(AuthLinks.changepassword, body: map);
      // print(response.body);
      if (response.body.contains('success')) {
        Fluttertoast.showToast(msg: "Password Changed");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const Authetication()),
            (route) => false);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } catch (e) {
      print(e);
    }
  }

  Future getunits() async {
    try {
      http.Response response = await http.get(AuthLinks.getunits);
      // print(response.body);
    } catch (e) {
      print(e);
    }
  }

  saveLogin(var data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('memberid', data[1]['logdata']['memberid']);
    sharedPreferences.setString('name', data[1]['logdata']['membername']);
    sharedPreferences.setString('number', data[1]['logdata']['phno']);
    sharedPreferences.setString('unitname', data[1]['logdata']['unitname']);
    sharedPreferences.setString('unitid', data[1]['logdata']['unitid']);
    sharedPreferences.setString('units_id', data[1]['logdata']['units_id']);
    sharedPreferences.setString('region_id', data[1]['logdata']['region_id']);
    sharedPreferences.setString(
        'passbook_no', data[1]['logdata']['passbook_no']);
  }

  String presidentid = '';
  Future savePresidentDetails({required List<dynamic> value}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    presidentid = value[1]['logdata']['presidentid'].toString();
    sharedPreferences.setString(
        'ppresidentid', value[1]['logdata']['presidentid'].toString());
    sharedPreferences.setString(
        'ppassword', value[1]['logdata']['password'].toString());
    sharedPreferences.setString(
        'punitname', value[1]['logdata']['unitname'].toString());
    sharedPreferences.setString(
        'pdistrict', value[1]['logdata']['district'].toString());
    sharedPreferences.setString(
        'pmemberid', value[1]['logdata']['memberid'].toString());
    sharedPreferences.setString(
        'pname', value[1]['logdata']['name'].toString());
    sharedPreferences.setString(
        'pplace', value[1]['logdata']['place'].toString());
    sharedPreferences.setString(
        'pphno', value[1]['logdata']['phno'].toString());
    sharedPreferences.setString(
        'punitId', value[1]['logdata']['unit_id'].toString());
    sharedPreferences.setString(
        'pregionId', value[1]['logdata']['region_id'].toString());
    sharedPreferences.setString(
        'ppassbookNo', value[1]['logdata']['passbook_no'].toString());
    sharedPreferences.setString(
        'pmessagecount', value[3]['messagecount'].toString());
    notifyListeners();
  }

  Future saveRegionalLogin({required List<dynamic> value}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    // presidentid = value[1]['logdata']['presidentid'].toString();
    sharedPreferences.setString(
        'regionId', value[1]['logdata']['region_id'].toString());
    sharedPreferences.setString(
        'rpassword', value[1]['logdata']['password'].toString());
    sharedPreferences.setString(
        'rname', value[1]['logdata']['region'].toString());
    sharedPreferences.setString(
        'rphno', value[1]['logdata']['ph_no'].toString());
    sharedPreferences.setString(
        'rpassbookNo', value[1]['logdata']['passbook_no'].toString());
    sharedPreferences.setString(
        'rmessagecount', value[3]['messagecount'].toString());
    notifyListeners();
  }

  Future saveAdminLogin({required List<dynamic> value}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    // presidentid = value[1]['logdata']['presidentid'].toString();
    sharedPreferences.setString(
        'adminId', value[1]['logdata']['admin_id'].toString());
    sharedPreferences.setString(
        'adminPassword', value[1]['logdata']['password'].toString());
    sharedPreferences.setString(
        'adminName', value[1]['logdata']['admin_name'].toString());
    sharedPreferences.setString(
        'adminPhone', value[1]['logdata']['ph_no'].toString());

    notifyListeners();
  }

  /*  savePresidentSignupDetails({required List<dynamic> value}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    presidentid = value[1]['logdata']['presidentid'].toString();

    sharedPreferences.setString(
        'ppassword', value[1]['logdata']['password'].toString());
    sharedPreferences.setString(
        'punitname', value[1]['logdata']['unit_name'].toString());
    sharedPreferences.setString(
        'punitId',
        value[1]['logdata']['unit_id']
            .toString()); /* 
    sharedPreferences.setString(
        'pdistrict', value[1]['logdata']['district'].toString()); */
    sharedPreferences.setString(
        'pmemberid',
        value[1]['logdata']['memberid']
            .toString()); /* 
    sharedPreferences.setString(
        'pname', value[1]['logdata']['name'].toString()); */
    sharedPreferences.setString(
        'pplace', value[1]['logdata']['place'].toString());
    sharedPreferences.setString(
        'pphno', value[1]['logdata']['ph_no'].toString());
    sharedPreferences.setString(
        'pregionId', value[1]['logdata']['region_id'].toString());
    sharedPreferences.setString(
        'ppassbookNo', value[1]['logdata']['passbook_no'].toString());
    /*  sharedPreferences.setString(
        'pmessagecount', value[3]['messagecount'].toString()); */
    notifyListeners();
  }
 */
  setLoginFlag(bool flag) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('flag', true);
    chooseShg();
    setexisting();
  }

  signuppresident({required BuildContext context}) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['regionid'] = '1';
    map['unitid'] = unitid;
    map['uphone'] = phone;
    map['uplace'] = place;
    map['udistrict'] = '';
    map['unitname'] = username;
    map['password'] = password;
    try {
      http.Response response =
          await http.post(AuthLinks.signuppresident, body: map);
      // print(response.body);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        // var value = jsonDecode(response.body);
        // savePresidentSignupDetails(value: value);
        // Fluttertoast.showToast(msg: "Password Changed");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const Authetication()),
            (route) => false);
      } else {
        ProgressDialog.hide(context);

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } catch (e) {
      print(e);
    }

    ProgressDialog.hide(context);
  }

  Future signinunit(BuildContext context) async {
    ProgressDialog.show(context: context, status: 'Please Wait');

    var map = <String, dynamic>{};
    map['mobile'] = phone; //'9995959595'; //phone;
    map['password'] = password; // password;

    try {
      http.Response response = await http.post(AuthLinks.signinunit, body: map);
      if (response.body.contains('Success')) {
        List<dynamic> data = jsonDecode(response.body);
        saveUnitDetails(value: data);
        userStatus('unit');
        // await savePresidentDetails(value: data);
        Fluttertoast.showToast(msg: 'Success');
        ProgressDialog.hide(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const UnitHome()),
            (route) => false);
        // return result;
      } else if (response.body.contains('invalid password')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Incorrect password');
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Time Out');
      ProgressDialog.hide(context);
    }
    notifyListeners();
  }

  saveUnitDetails({required List<dynamic> value}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.setString(
        'unitId', value[1]['logdata']['unit_id'].toString());

    sharedPreferences.setString('unit', value[1]['logdata']['unit'].toString());
    sharedPreferences.setString(
        'phone', value[1]['logdata']['ph_no'].toString());
    sharedPreferences.setString(
        'unitId', value[1]['logdata']['unit_id'].toString());
    sharedPreferences.setString(
        'regionId', value[1]['logdata']['region_id'].toString());
    sharedPreferences.setString(
        'passbookNo', value[1]['logdata']['passbook_no'].toString());
    sharedPreferences.setString(
        'password', value[1]['logdata']['password'].toString());
    sharedPreferences.setString(
        'messagecount', value[3]['messagecount'].toString());
  }

  //president configaration

  List<DropDownValueModel> unitList = [];
  Future getunitsDropdown() async {
    var map = <String, dynamic>{};

    map['presidentid'] = presidentid; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.getallunits, body: map);
      if (response.body.contains('Success')) {
        var data = jsonDecode(response.body);
        var length = data[1]['logdata'].length;
        for (int i = 0; i < length; i++) {
          unitList.add(DropDownValueModel(
              name: data[1]['logdata'][i]['unit'],
              value: data[1]['logdata'][i]['unitid']));
        }

        // return result;
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  String unitname = '';
  String unitid = '';
  setunitname(val) {
    unitname = val;
    notifyListeners();
  }

  setunitid(va) {
    unitid = va;
    // print(unitid);
    // print(unitname);
    notifyListeners();
  }
}
