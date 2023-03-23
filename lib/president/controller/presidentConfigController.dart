// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sacco_management/apis/apiLinks.dart';
import 'package:sacco_management/president/view/presidenthome.dart';
import 'package:sacco_management/widgets/progressDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PresidentConfigController extends ChangeNotifier {
  String presidentid = '';
  getPresidentID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    presidentid = preferences.getString('ppresidentid').toString();
    notifyListeners();
  }

  bool festivafund = false;
  bool banklinkage = false;
  bool insurance = false;
  bool grant = false;
  bool sessfund = false;
  bool medicalaid = false;
  bool profit = false;
  bool shares = false;
  String? fest = '';
  String? bank = '';
  String? insu = '';
  String? gra = '';
  String? sess = '';
  String? medi = '';
  String? prof = '';
  String? shar = '';
  setShares() {
    shares = !shares;
    notifyListeners();
  }

  setProfit() {
    profit = !profit;
    notifyListeners();
  }

  setMedicalAid() {
    medicalaid = !medicalaid;
    notifyListeners();
  }

  setSessfund() {
    sessfund = !sessfund;
    notifyListeners();
  }

  setGrant() {
    grant = !grant;
    notifyListeners();
  }

  setInsurance() {
    insurance = !insurance;
    notifyListeners();
  }

  setBankLinkage() {
    banklinkage = !banklinkage;
    notifyListeners();
  }

  setFestivalfund() {
    festivafund = !festivafund;
    notifyListeners();
  }

  savePreferences(BuildContext context) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    await getPresidentID();
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid; //'9995959595'; //phone;
    map['festfund'] = festivafund.toString(); // password;
    map['banklinkage'] = banklinkage.toString(); // password;
    map['insurance'] = insurance.toString(); // password;
    map['grant'] = grant.toString(); // password;
    map['sessfund'] = sessfund.toString(); // password;
    map['medicalaid'] = medicalaid.toString(); // password;
    map['profit'] = profit.toString(); // password;
    map['shares'] = shares.toString(); // password;

    try {
      http.Response response =
          await http.post(AuthLinks.presidentconfig, body: map);
      if (response.body.contains('Success')) {
        Fluttertoast.showToast(msg: '''Saved !!''');
        await getPresidentConfig();

        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const PresidentHome()),
            (route) => false);
      } else if (response.body.contains('failed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Something went wrong');
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

  Future getPresidentConfig() async {
    getPresidentID();
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.getPresidentConfig, body: map);
      if (response.body.contains('Success')) {
        var value = jsonDecode(response.body);
        await savePreference(value).then(
          (value) => getPreference(),
        );
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future savePreference(var value) async {
    SharedPreferences prf = await SharedPreferences.getInstance();
    prf.setString('festivafund', value[1]['data'][0]['festfund']);
    prf.setString('banklinkage', value[1]['data'][0]['banklinkage']);
    prf.setString('insurance', value[1]['data'][0]['insurance']);
    prf.setString('grant', value[1]['data'][0]['grants']);
    prf.setString('sessfund', value[1]['data'][0]['sess']);
    prf.setString('medicalaid', value[1]['data'][0]['medicalaid']);
    prf.setString('profit', value[1]['data'][0]['profit']);
    prf.setString('shares', value[1]['data'][0]['shares']);
    notifyListeners();
  }

  getPreference() async {
    SharedPreferences prf = await SharedPreferences.getInstance();
    fest = prf.getString('festivafund');
    bank = prf.getString('banklinkage');
    insu = prf.getString('insurance');
    gra = prf.getString('grant');
    sess = prf.getString('sessfund');
    medi = prf.getString('medicalaid');
    prof = prf.getString('profit');
    shar = prf.getString('shares');
    notifyListeners();
  }
}
