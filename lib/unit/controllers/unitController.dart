// ignore_for_file: use_build_context_synchronously, file_names, empty_catches

import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sacco_management/apis/apiLinks.dart';
import 'package:sacco_management/splashScreen.dart';
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
  // List<DropDownValueModel> shgList = [];
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

  List<DropDownValueModel> banks = [];

  Future getAllBanks() async {
    var map = <String, dynamic>{};

    map['passbookno'] = passbookNo;

    try {
      http.Response response =
          await http.post(AuthLinks.unitGetAllBanks, body: map);
      if (response.body.contains('bankdata')) {
        var data = jsonDecode(response.body);
        var length = data[0]['bankdata'].length;
        for (int i = 0; i < length; i++) {
          banks.add(DropDownValueModel(
              name: data[0]['bankdata'][i]['bank'],
              value: data[0]['bankdata'][i]['bank']));
        }
      }
    } catch (e) {}
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
    } catch (e) {}
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
      Fluttertoast.showToast(msg: 'connection timeout');
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
    }
    notifyListeners();
  }

  List<DropDownValueModel> shglist = [];
  List<DropDownValueModel> shgAllMemberList = [];
  List<DropDownValueModel> shgMemberList = [];
  List<DropDownValueModel> presidentList = [];

  Future getallSHG({required BuildContext context, int? opt = 1}) async {
    var map = <String, dynamic>{};

    map['passbookno'] = passbookNo; // password;
    map['unitid'] = unitId; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.getAllshgUnit, body: map);
      if (response.body.contains('sdata')) {
        var data = jsonDecode(response.body);

        if (opt == 1) {
        } else {
          var length = data[0]['sdata'].length;
          for (int i = 0; i < length; i++) {
            // print(data[0]['memberdata'][i]);
            shglist.add(DropDownValueModel(
                name: data[0]['sdata'][i]['shgname'],
                value: data[0]['sdata'][i]['passbookno']));
          }
          notifyListeners();
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

  Future getAllSHGMembers() async {
    var map = <String, dynamic>{};

    // map['passbookno'] = passbookNo; // password;
    map['unitid'] = unitId; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.unitGetAllshgMember, body: map);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var length = data[0]['message'].length;
        if (length != 0) {
          for (int i = 0; i < length; i++) {
            // print(data[0]['memberdata'][i]);
            shgAllMemberList.add(
              DropDownValueModel(
                name: data[0]['message'][i]['member_name'],
                value: data[0]['message'][i]['passbook_no'],
              ),
            );
          }
        }
      } else {}
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    notifyListeners();
  }

  Future getSHGMembers({required String shgpassbook}) async {
    var map = <String, dynamic>{};

    map['shgpassbookno'] = shgpassbook; // password;
    map['unitpassbookno'] = passbookNo; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.unitGetshgMember, body: map);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var length = data[0]['message'].length;
        if (length != 0) {
          for (int i = 0; i < length; i++) {
            // print(data[0]['memberdata'][i]);
            shgMemberList.add(DropDownValueModel(
                name: data[0]['message'][i]['member_name'],
                value: data[0]['message'][i]['passbook_no']));
          }
        }
      } else {}
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    notifyListeners();
  }

  Future getUnitBorrowersList(
      {required BuildContext context, required String type}) async {
    var map = <String, dynamic>{};

    map['unitpassbookno'] = passbookNo; // password;
    map['type'] = type; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.unitLoansHGBorrowers, body: map);
      if (response.body.contains('shgdata')) {
        // List list = response.body as List;
        var data = jsonDecode(response.body);

        return data;
      }
      if (response.body.contains('memberdata')) {
        // List list = response.body as List;
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

  Future getAllPresident({required BuildContext context}) async {
    try {
      http.Response response = await http.get(AuthLinks.unitGetpresidentlist);
      if (response.body.contains('shg')) {
        var data = jsonDecode(response.body);

        var length = data[0]['shg'].length;
        for (int i = 0; i < length; i++) {
          // print(data[0]['memberdata'][i]);
          presidentList.add(DropDownValueModel(
              name: data[0]['shg'][i]['unit_name'],
              value: data[0]['shg'][i]['president_id']));
        }
        notifyListeners();
      } else {
        var data = [];
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    notifyListeners();
  }

  Future unitTrackshgsambadhyam(
      {required BuildContext context, required String shgpassbookno}) async {
    var map = <String, dynamic>{};

    map['shgpassbookno'] = shgpassbookno; // password;
    map['unitpassbookno'] = passbookNo; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.unitTrackshgsambadhyam, body: map);
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

  Future unitLoanShgBorrowers(
      {required BuildContext context, required String shgpassbookno}) async {
    var map = <String, dynamic>{};

    map['shgpassbookno'] = shgpassbookno; // password;
    map['unitpassbookno'] = passbookNo; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.unitLoanShgBorrowers, body: map);
      if (response.body.contains('shgdata')) {
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

  Future fetchYearlyInterestUnit(
      {required BuildContext context, required String shgpassbookno}) async {
    var map = <String, dynamic>{};

    map['shgpassbookno'] = shgpassbookno; // password;
    map['unitpassbookno'] = passbookNo; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.unitShgyearlyinterest, body: map);
      if (response.body.contains('Failed')) {
        var data = [];
        return data;
      } else {
        var data = jsonDecode(response.body);

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

  Future unitshgmedicalAidTransfer({
    required BuildContext context,
    required String shgPassbookno,
  }) async {
    var map = <String, dynamic>{};

    map['shgpassbookno'] = shgPassbookno;
    map['unitpassbookno'] = passbookNo;

    try {
      http.Response response =
          await http.post(AuthLinks.unitshgmedicalaidtransfer, body: map);
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

  Future viewUnitBankLinkageFromRegion({
    required BuildContext context,
  }) async {
    var map = <String, dynamic>{};
    map['unitpassbookno'] = passbookNo;

    try {
      http.Response response =
          await http.post(AuthLinks.unitViewbanklinkage, body: map);
      if (response.body.contains('Success')) {
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

  String savings = '';
  String insurance = '';
  Future unitgetAlldata({required BuildContext context}) async {
    var map = <String, dynamic>{};
    map['passbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.getUnitdata, body: map);
      if (response.body.contains('unitdata')) {
        var data = jsonDecode(response.body);
        savings = data[0]['unitdata'][0]['sambadhyam'].toString();
        insurance = data[0]['unitdata'][0]['insurance'].toString();
        notifyListeners();
      } else {
        var data = [];
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    notifyListeners();
  }

  Future unitViewGrants({required BuildContext context}) async {
    var map = <String, dynamic>{};
    map['unitpassbookno'] = '701'; //passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitViewGrants, body: map);
      if (response.body.contains('grantdata')) {
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

  Future payBankLinkageRegion({
    required BuildContext context,
    required String loanid,
    required String paydate,
  }) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Please wait');

    map['loanid'] = loanid;
    map['pdate'] = paydate;
    map['unitpassbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitBanklinkagepayment, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Transfered');
      } else if (response.body
          .contains('There is no bank linkage from member to pay the region')) {
        Fluttertoast.showToast(
            msg: 'There is no bank linkage from member to pay the region');
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

  Future unitpaySavingsInterestToRegion({
    required BuildContext context,
    required String date,
    required String amount,
    required String passbookno,
  }) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Please wait');

    map['date'] = date;
    map['amount'] = amount;
    map['shgpassbookno'] = passbookno;
    map['unitpassbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitShgyearlyinterestPay, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Success');
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed');
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
        ProgressDialog.hide(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
      }
    } catch (e) {
      ProgressDialog.hide(context);

      Fluttertoast.showToast(msg: e.toString());
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future transfergrantunit({
    required BuildContext context,
    required String grantid,
    required String shgname,
    required String type,
    required String transdate,
    required String amount,
    required String gdate,
    required String shgpassbook,
  }) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(
        context: context, status: 'Transfering Grant to $shgname');

    map['grantid'] = grantid;
    map['transferdate'] = transdate;
    map['type'] = type;
    map['amount'] = amount;
    map['grantdate'] = gdate;
    map['shgpassbookno'] = shgpassbook;
    map['unitpassbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitTransferGranttoShg, body: map);
      if (response.body.contains('Grant Transfered')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Grant Transfered To $shgname');
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

  Future addMedicalAidIndividual({
    required BuildContext context,
    required String name,
    required String amount,
    required String mobile,
    required String place,
  }) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Please wait');

    map['name'] = name;
    map['amount'] = amount;
    map['place'] = place;
    map['mobile'] = mobile;
    map['passbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitAddmedicalaidindividual, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Added');
      } else if (response.body.contains('Insufficient Medical Aid')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Insufficient Medical Aid');
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

  Future unitTransferMedicalAid(
      {required BuildContext context, required String mid}) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Please wait');

    map['mid'] = mid;
    map['unitpassbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitmedicalaidtransfer, body: map);
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

    map['amount'] = unitsessAmount;
    map['unitpassbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.transferUnitPayment, body: map);
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

  Future unitSendMessagetoShg(
      {required BuildContext context,
      required String message,
      required String name,
      required String shgpassbook}) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Sending message to $name');

    map['message'] = message;
    map['shgpassbookno'] = shgpassbook;
    map['unitpassbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitSendMessageShg, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: 'sent');
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

  Future unitSendMessagetoAllShg(
      {required BuildContext context,
      required String message,
      required String name,
      required String shgpassbook}) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Sending message to $name');

    map['message'] = message;
    // map['shgpassbookno'] = shgpassbook;
    map['passbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitSendMessageAllShg, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: 'sent');
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

  bool isintresest = true;
  bool isamount = false;
  issetinterestclicked() {
    isamount = false;
    isintresest = true;

    notifyListeners();
  }

  issetamountclicked() {
    isintresest = false;
    isamount = true;

    notifyListeners();
  }

  Future unitsendBankPayment(
      {required BuildContext context,
      required String bank,
      required String interest,
      required String amount,
      required String date}) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Sending message to $bank');

    map['bank'] = bank;
    map['interest'] = interest;
    map['amount'] = amount;
    map['passbookno'] = passbookNo;
    map['date'] = date;
    try {
      http.Response response =
          await http.post(AuthLinks.unitPaybankAmount, body: map);
      if (response.body.contains('Yearly Balance paid to Bank')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'sent');
      } else if (response.body.contains('Yearly Balance Failed to pay')) {
        ProgressDialog.hide(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Failed to pay');
      } else {}
    } catch (e) {
      ProgressDialog.hide(context);

      Fluttertoast.showToast(msg: e.toString());
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future addUnitIndLoan(
      {required BuildContext context,
      required String amount,
      required String period,
      required String memberpassbookno,
      required String shgpassbookno,
      required String date}) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Adding Loan...');

    map['period'] = period;
    map['amount'] = amount;
    map['memberpassbookno'] = memberpassbookno;
    map['shgpassbookno'] = shgpassbookno;
    map['unitpassbookno'] = passbookNo;
    map['date'] = date;
    try {
      http.Response response =
          await http.post(AuthLinks.unitloanindAdd, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Added');
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Failed to Add');
      } else {}
    } catch (e) {
      ProgressDialog.hide(context);

      Fluttertoast.showToast(msg: e.toString());
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future addUnitExternalLoan(
      {required BuildContext context,
      required String amount,
      required String period,
      required String interest,
      required String id,
      required String status,
      required String date}) async {
    DateTime today = DateTime.now();
    ProgressDialog.show(context: context, status: 'Please Wait');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date1 = formatter.format(today);
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Adding Loan...');
    map['unitid'] = unitId;
    map['date'] = date1;
    map['amount'] = amount;
    map['period'] = period;
    map['interest'] = interest;
    map['id'] = id;
    map['status'] = status;
    map['pdate'] = date;
    try {
      http.Response response =
          await http.post(AuthLinks.unitAddExternaLoan, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Added');
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Failed to Add');
      } else if (response.body
          .contains('Loan Amount is higher than Sambadhyam')) {
        ProgressDialog.hide(context);

        Fluttertoast.showToast(msg: 'Insufficient Balance');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Failed to Add');
      } else {}
    } catch (e) {
      ProgressDialog.hide(context);

      Fluttertoast.showToast(msg: e.toString());
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future unitsendBankInterestrPayment(
      {required BuildContext context,
      required String bank,
      required String interest,
      required String date}) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Sending message to $bank');

    map['bank'] = bank;
    map['interest'] = interest;
    map['passbookno'] = passbookNo;
    map['date'] = date;
    try {
      http.Response response =
          await http.post(AuthLinks.unitPaybankAmount, body: map);
      if (response.body.contains('Yearly Interest paid to Bank')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'sent');
      } else if (response.body
          .contains('Already given Yearly Balance for this year')) {
        ProgressDialog.hide(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(
            msg: 'Already given Yearly Balance for this year');
      } else {}
    } catch (e) {
      ProgressDialog.hide(context);

      Fluttertoast.showToast(msg: e.toString());
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  unitRegisterNonMemeber(BuildContext context,
      {required String number,
      required String mailid,
      required String shg}) async {
    ProgressDialog.show(context: context, status: 'Adding Member');
    var map = <String, dynamic>{};
    map['phone'] = number;
    map['mail'] = mailid;
    map['group'] = 'Non Shg Member';
    map['shg'] = shg;
    map['unit'] = unitId;
    try {
      http.Response response =
          await http.post(AuthLinks.pAddExternalMember, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: "Added Member");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
      } else if (response.body.contains("Already registered")) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: "This Number Already Registered");
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
        ProgressDialog.hide(context);
      }
    } catch (e) {
      print(e);
      ProgressDialog.hide(context);
    }
    notifyListeners();
  }

  Future unitTranferInsurance(
      {required BuildContext context,
      required String amount,
      required String date}) async {
    var map = <String, dynamic>{};
    ProgressDialog.show(context: context, status: 'Tranfering Insurance');

    map['unitpassbookno'] = passbookNo;
    map['amount'] = amount;
    map['date'] = date;
    try {
      http.Response response =
          await http.post(AuthLinks.unitTransferinsurance, body: map);
      if (response.body.contains('Transfer sucessfull')) {
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'Transfered');
      } else if (response.body
          .contains('There is no insurance amount to transfer!!')) {
        ProgressDialog.hide(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
        Fluttertoast.showToast(msg: 'There is no insurance');
      } else {}
    } catch (e) {
      ProgressDialog.hide(context);

      Fluttertoast.showToast(msg: e.toString());
      Fluttertoast.showToast(msg: 'Faied');
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  List<DropDownValueModel> income = [];
  List<DropDownValueModel> expense = [];
  Future getAllUnitAccountingHead() async {
    var map = <String, dynamic>{};

    map['passbookno'] = passbookNo;
    try {
      http.Response response =
          await http.post(AuthLinks.unitGetaccountinghead, body: map);
      if (response.body.contains('expensedata') ||
          response.body.contains('incomedata')) {
        var data = jsonDecode(response.body);
        if (response.body.contains('expensedata')) {
          var length = data[0]['expensedata'].length;
          for (int i = 0; i < length; i++) {
            // print(data[0]['memberdata'][i]);
            expense.add(DropDownValueModel(
                name: data[0]['expensedata'][i]['head'],
                value: data[0]['expensedata'][i]['head']));
          }
          notifyListeners();
        } else if (response.body.contains('incomedata')) {
          var length = data[1]['incomedata'].length;
          for (int i = 0; i < length; i++) {
            // print(data[0]['memberdata'][i]);
            income.add(DropDownValueModel(
                name: data[1]['incomedata'][i]['head'],
                value: data[1]['incomedata'][i]['head']));
          }
          notifyListeners();
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
      print(e);
    }
    notifyListeners();
  }

  Future addUnitAccountingHead(
      BuildContext context, String? type, String? accountinghead) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['passbookno'] = passbookNo;
    map['accountinghead'] = accountinghead;
    map['type'] = type;

    try {
      http.Response response =
          await http.post(AuthLinks.unitAddaccountinghead, body: map);
      if (response.body.contains('Accounting head added')) {
        Fluttertoast.showToast(msg: 'successfully added');
        await getAllUnitAccountingHead();
        ProgressDialog.hide(context);
        /*  Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const SplashScreen(),
            ),
            (route) => false); */
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      ProgressDialog.hide(context);
      print(e);
    }
    notifyListeners();
  }

  Future logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences
        .clear()
        .then((value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const SplashScreen(),
            ),
            (route) => false));
    notifyListeners();
  }

  Future payUnitShgLoan(
    String id,
    BuildContext context,
    String loanamount,
    String penality,
    String date,
  ) async {
    var map = <String, dynamic>{};
    map['date'] = date;
    map['amount'] = loanamount;
    map['loanid'] = id;
    map['penality'] = penality;
    map['unitpassbookno'] = passbookNo;

    try {
      http.Response response =
          await http.post(AuthLinks.unitLoanshgPay, body: map);
      if (response.body.contains('Loan Payment done')) {
        Fluttertoast.showToast(msg: 'Loan Paid successfully');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Failed')) {
        Fluttertoast.showToast(msg: 'Failed to Pay');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
      } else {
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future addUnitLoantoSHG(
    BuildContext context,
    String loanamount,
    String period,
    String shgpassbookno,
  ) async {
    DateTime today = DateTime.now();

    ProgressDialog.show(context: context, status: 'Please Wait');
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(today);
    var map = <String, dynamic>{};
    map['date'] = date;
    map['amount'] = loanamount;
    map['period'] = period;
    map['shgpassbookno'] = shgpassbookno;
    map['unitpassbookno'] = passbookNo;

    try {
      http.Response response =
          await http.post(AuthLinks.unitloanshgdetails, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Loan added successfully');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to add');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      ProgressDialog.hide(context);
      print(e);
    }
    notifyListeners();
  }

  Future closeUnitLoantoSHG(
    BuildContext context,
    String loanid,
  ) async {
    var map = <String, dynamic>{};
    map['loanid'] = loanid;
    map['type'] = 'CLOSE';
    map['unitpassbookno'] = passbookNo;

    try {
      http.Response response =
          await http.post(AuthLinks.unitloanindborrowersdetails, body: map);
      if (response.body.contains('Loan Closed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Loan Closed');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Loan Payment not Completed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to Close');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      ProgressDialog.hide(context);
      print(e);
    }
    notifyListeners();
  }

  Future closeUnitLoantoIndividuals(
    BuildContext context,
    String memeberpassbook,
  ) async {
    var map = <String, dynamic>{};
    map['memberpassbookno'] = memeberpassbook;
    map['unitpassbookno'] = passbookNo;

    try {
      http.Response response =
          await http.post(AuthLinks.unitloanindborrowers, body: map);
      if (response.body.contains('memberdata')) {
        var data = jsonDecode(response.body);

        return data;
      } else {
        var data = [];
        return data;
      }
    } catch (e) {
      ProgressDialog.hide(context);
      print(e);
    }
    notifyListeners();
  }

  Future getExternalMember() async {
    var map = <String, dynamic>{};
    map['unitid'] = unitId;

    try {
      http.Response response =
          await http.post(AuthLinks.unitGetExternalMember, body: map);
      if (response.body.contains('memberdata')) {
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

  Future payUnitIndividualLoan(
    String id,
    BuildContext context,
    String loanamount,
    String penality,
    String date,
  ) async {
    var map = <String, dynamic>{};
    map['date'] = date;
    map['amount'] = loanamount;
    map['loanid'] = id;
    map['penality'] = penality;
    map['unitpassbookno'] = passbookNo;

    try {
      http.Response response =
          await http.post(AuthLinks.unitLoanIndPay, body: map);
      if (response.body.contains('Loan Payment done')) {
        Fluttertoast.showToast(msg: 'Loan Paid successfully');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Failed')) {
        Fluttertoast.showToast(msg: 'Failed to Pay');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
      } else {
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future closeUnitIndLoan(
    BuildContext context,
    String loanid,
  ) async {
    var map = <String, dynamic>{};
    map['loanid'] = loanid;
    map['type'] = 'CLOSE';
    map['unitpassbookno'] = passbookNo;

    try {
      http.Response response =
          await http.post(AuthLinks.unitcloseindLoan, body: map);
      if (response.body.contains('Loan Closed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Loan Closed');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Loan Payment not Completed')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Failed to Close');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const UnitHome(),
            ),
            (route) => false);
      } else {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      ProgressDialog.hide(context);
      print(e);
    }
    notifyListeners();
  }
}
