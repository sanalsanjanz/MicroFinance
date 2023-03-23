// ignore_for_file: use_build_context_synchronously, empty_catches

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sacco_management/apis/apiLinks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MemberConfigController extends ChangeNotifier {
  String? presidentid = '';
  getPresidentID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    presidentid = preferences.getString('unitid').toString();
    notifyListeners();
  }

  String? fest = '';
  String? bank = '';
  String? insu = '';
  String? gra = '';
  String? sess = '';
  String? medi = '';
  String? prof = '';
  String? shar = '';

  Future getMemberConfigData() async {
    await getPresidentID();
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid.toString();

    try {
      http.Response response =
          await http.post(AuthLinks.getPresidentConfig, body: map);
      if (response.body.contains('Success')) {
        var value = jsonDecode(response.body);
        await savePreference(value).then(
          (value) => getPreference(),
        );
      } else {}
    } catch (e) {}
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
