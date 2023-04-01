// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/apis/apiLinks.dart';
import 'package:sacco_management/authentication/controller/authController.dart';
import 'package:sacco_management/president/view/presidenthome.dart';
import 'package:sacco_management/splashScreen.dart';
import 'package:sacco_management/widgets/progressDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PresidentController extends ChangeNotifier {
  String unitname = '';
  String presidentid = '';
  String phone = '';
  String password = '';
  String name = '';
  String messagecount = '';
  String passbookno = '';
  String memberid = '';
  var date = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String formatted = '';

  String meetdate = 'choose date';
  setmeetDate(String value) {
    meetdate = value;
    notifyListeners();
  }

  getsaved() async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(DateTime.now());
    formatted = date;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    presidentid = preferences.getString('ppresidentid').toString();
    unitname = preferences.getString('punitname').toString();

    name = preferences.getString('pname').toString();
    passbookno = preferences.getString('ppassbookNo').toString();

    messagecount = preferences.getString('pmessagecount').toString();
    memberid = preferences.getString('pmemberid').toString();
    phone = preferences.getString('pphno').toString();
    password = preferences.getString('ppassword').toString();
    notifyListeners();
  }

  Future attendance() async {
    var map = <String, dynamic>{};
    map['date'] = DateTime.now().toString(); //phone;
    map['presidentid'] = presidentid; // password;

    try {
      http.Response response = await http.post(AuthLinks.attendance, body: map);
      if (response.body.contains('memberdata')) {
        var data = jsonDecode(response.body);

        return data;
        // return result;
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future memberlist() async {
    var map = <String, dynamic>{};

    map['presidentid'] = presidentid; // password;

    try {
      http.Response response = await http.post(AuthLinks.memberlist, body: map);
      if (response.body.contains('memberdata')) {
        var data = jsonDecode(response.body);

        return data;
        // return result;
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future groupList() async {
    var map = <String, dynamic>{};

    map['shgid'] = presidentid; // password;

    try {
      http.Response response =
          await http.post(AuthLinks.getothershg, body: map);
      if (response.body.contains('shgdata')) {
        var data = jsonDecode(response.body);

        return data;
        // return result;
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future getDataa(BuildContext context) async {
    await getsaved();
    var map = <String, dynamic>{};
    map['uphone'] = phone;
    map['password'] = password;

    try {
      http.Response response =
          await http.post(AuthLinks.signinpresident, body: map);
      if (response.body.contains('Success')) {
        var data = jsonDecode(response.body);
        await Provider.of<AuthController>(context, listen: false)
            .savePresidentDetails(value: data)
            .then((value) => getsaved());
        return data;
        // return result;
      } else if (response.body.contains('invalid password')) {
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  initsattend() async {
    memmbers.isEmpty ? await memberlistDrop() : '';
    for (int i = 0; i <= memmbers.length; i++) {
      attend.insert(i, false);
    }
    // print(attend);
  }

  List<bool> attend = [];
  bool checkattendance = false;
  checkattenance(id, value) {
    for (int i = 0; i <= memmbers.length; i++) {
      if (attend[id] == true) {
        attend[id] = false;
      } else {
        attend[id] = true;
      }
    }
    /*  if (val.toString().contains(id)) {
      checkattendance = value;
    } else {
      checkattendance = value;
    } */
    notifyListeners();
  }

  List<String> val = [];
  markattendance({required String id}) {
    /* 
    Map<String, dynamic> maps = <String, dynamic>{};
    maps['id'] = id; */
    if (val.toString().contains(id)) {
      val.removeWhere((element) => element == id);
      // val.remove({'id': id});
    } else {
      val.add(id);
    }

    print(val);

    notifyListeners();
  }

  //mom
  String meetlocation = '';
  String meetattendance = '';
  String meetdecisions = '';
  String meetsummary = '';
  setmeetLocation(va) {
    meetlocation = va;
    notifyListeners();
  }

  setmeetattendance(va) {
    meetattendance = va;
    notifyListeners();
  }

  setmeetdecisions(va) {
    meetdecisions = va;
    notifyListeners();
  }

  setmeetsummary(va) {
    meetsummary = va;
    notifyListeners();
  }

  clear() {
    meetlocation = '';
    meetattendance = '';
    meetdecisions = '';
    meetsummary = '';
    notifyListeners();
  }

  attendancelist(BuildContext context) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(DateTime.now());
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['date'] = date;
    map['memberdata'] = val.toString();
    try {
      http.Response response =
          await http.post(AuthLinks.attendancelist, body: map);
      if (response.body.contains('Success')) {
        clear();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  addmember(BuildContext context,
      {required String number,
      required String mailid,
      required String password}) async {
    ProgressDialog.show(context: context, status: 'Adding Member');
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['uphone'] = number;
    map['umailid'] = mailid;
    map['password'] = password;
    try {
      http.Response response = await http.post(AuthLinks.addmember, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
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
    }
    notifyListeners();
  }

  Future savemom(BuildContext context) async {
    // print(meetdate);
    // print(meetlocation + meetattendance + meetdecisions + meetsummary);
    ProgressDialog.show(context: context, status: 'Adding MoM Record');

    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['meetdate'] = meetdate;
    map['location'] = meetlocation;
    map['attendance'] = meetattendance;
    map['decisions'] = meetdecisions;
    map['summary'] = meetsummary;

    try {
      http.Response response = await http.post(AuthLinks.momrecord, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        clear();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else {
        ProgressDialog.hide(context);
      }
    } catch (e) {
      print(e);
    }
    ProgressDialog.hide(context);
    notifyListeners();
  }

  Future getmomreport() async {
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    try {
      http.Response response = await http.post(AuthLinks.getmom, body: map);
      if (response.body.contains('Success')) {
        var data = jsonDecode(response.body);
        return data;
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future getMemberRequets() async {
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    try {
      http.Response response =
          await http.post(AuthLinks.memberRequest, body: map);
      if (response.body.contains('memberdata')) {
        var data = jsonDecode(response.body);
        return data;
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  double payunitAmount = 0;
  String paysessAmount = '0';
  Future sambhadyam() async {
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    try {
      http.Response response = await http.post(AuthLinks.sambhadyam, body: map);
      if (response.body.contains('memberdata')) {
        var data = jsonDecode(response.body);
        var savings = data[1]['sambhadyam'];
        paysessAmount = data[6]['sessfund'];
        payunitAmount = int.parse(savings) * (15 / 100);
        notifyListeners();
        return data;
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future acceptMemberRequest(
      String memberid, BuildContext context, String membername) async {
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['memberid'] = memberid;
    try {
      http.Response response =
          await http.post(AuthLinks.acceptmemberrequest, body: map);
      if (response.body.contains('Success')) {
        Fluttertoast.showToast(msg: '$membername is a member now !');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong !!!');
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future deletemember(
      String memberid, BuildContext context, String membername) async {
    var map = <String, dynamic>{};
    map['memberid'] = memberid;
    try {
      http.Response response =
          await http.post(AuthLinks.deletemember, body: map);
      if (response.body.contains('Success')) {
        Fluttertoast.showToast(msg: 'Removed $membername !');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong !!!');
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future unitloanborrowers() async {
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    try {
      http.Response response =
          await http.post(AuthLinks.unitloanborrowers, body: map);
      if (response.body.contains('loandata')) {
        var data = jsonDecode(response.body);
        return data;
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  String totalinterest = '0';
  double monthlyinterest = 0;
  Future interestpayment(
      String loanid, String interest, String period, String amount) async {
    var map = <String, dynamic>{};
    map['loanid'] = loanid;
    try {
      http.Response response =
          await http.post(AuthLinks.interestpayment, body: map);
      if (response.body.contains('monthly_interest')) {
        var data = jsonDecode(response.body);
        totalinterest = data[0]['monthly_interest'].toString();
        double a = (int.parse(interest) / 100);
        double b = a * int.parse(amount);
        monthlyinterest = b / int.parse(period);

        notifyListeners();
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future closeunitloan(String loanid, BuildContext context) async {
    var map = <String, dynamic>{};
    map['loanid'] = loanid;
    try {
      http.Response response =
          await http.post(AuthLinks.closeunitloan, body: map);
      if (response.body.contains('success')) {
        Fluttertoast.showToast(msg: 'Loan closed successfully');
        Navigator.of(context).pop();
      } else if (response.body.contains('Loan Payment not completed')) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: 'Loan Payment not completed');
      } else {
        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  String loanamount = '0';
  String period = '0';
  String interest = '0';
  String paymentdate = '0';
  setloanamt(value) {
    loanamount = value;
    notifyListeners();
  }

  setperiod(val) {
    period = val;
    notifyListeners();
  }

  setinterest(val) {
    interest = val;
    notifyListeners();
  }

  setpaydate(val) {
    paymentdate = val;
    notifyListeners();
  }

  Future giveShreyasloan(
      String id, String membername, BuildContext context) async {
    DateTime today = DateTime.now();

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(today);
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['date'] = date;
    map['amount'] = loanamount;
    map['period'] = period;
    map['interest'] = interest;
    map['id'] = id;
    map['status'] = membername == name ? 'yes' : 'no';
    map['pdate'] = paymentdate;
    try {
      http.Response response = await http.post(AuthLinks.unitloan, body: map);
      if (response.body.contains('Success')) {
        Fluttertoast.showToast(msg: 'Loan added successfully');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Already added')) {
        Fluttertoast.showToast(msg: 'Loan already added');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
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

  Future addunitloanpayment(
      {required BuildContext context,
      required String amount,
      required String loanid,
      required String panality}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(DateTime.now());
    var map = <String, dynamic>{};
    map['amount'] = amount;
    map['loanid'] = loanid;
    map['date'] = date.toString();
    map['penality'] = panality;

    try {
      http.Response response =
          await http.post(AuthLinks.addunitloanpayment, body: map);
      if (response.body.contains('Success')) {
        Fluttertoast.showToast(msg: 'Loan Payment Successfull');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
        // return result;
      } else if (response.body.contains('failed')) {
        Fluttertoast.showToast(msg: 'Failed');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future addunitloaninterestpayment(
      {required BuildContext context, required String loanid}) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(DateTime.now());
    var map = <String, dynamic>{};

    map['loanid'] = loanid;
    map['date'] = date.toString();
    map['interest'] = monthlyinterest.toString();

    try {
      http.Response response =
          await http.post(AuthLinks.addinterestpayment, body: map);
      if (response.body.contains('Success')) {
        Fluttertoast.showToast(msg: 'Interest Payment Successfull');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
        // return result;
      } else if (response.body.contains('failed')) {
        Fluttertoast.showToast(msg: 'Failed');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  List<DropDownValueModel> memmbers = [];
  String membid = 'All';
  String typeofreport = '';
  settypeofreport(value) {
    typeofreport = value;
    notifyListeners();
  }

  setmembid(id) {
    membid = id;
    notifyListeners();
  }

  Future memberlistDrop() async {
    var map = <String, dynamic>{};

    map['presidentid'] = presidentid; // password;

    try {
      http.Response response = await http.post(AuthLinks.memberlist, body: map);
      if (response.body.contains('memberdata')) {
        var data = jsonDecode(response.body);
        var length = data[0]['memberdata'].length;
        for (int i = 0; i < length; i++) {
          // print(data[0]['memberdata'][i]);
          memmbers.add(DropDownValueModel(
              name: data[0]['memberdata'][i]['membername'],
              value: data[0]['memberdata'][i]['memberid']));
        }
        // print(memmbers);

        // return result;
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  List<DropDownValueModel> memmbpassbook = [];
  Future membpassbook() async {
    var map = <String, dynamic>{};

    map['presidentid'] = presidentid; // password;

    try {
      http.Response response = await http.post(AuthLinks.memberlist, body: map);
      if (response.body.contains('memberdata')) {
        var data = jsonDecode(response.body);
        var length = data[0]['memberdata'].length;
        for (int i = 0; i < length; i++) {
          // print(data[0]['memberdata'][i]);
          memmbpassbook.add(DropDownValueModel(
              name: data[0]['memberdata'][i]['membername'],
              value: data[0]['memberdata'][i]['passbookno']));
        }
        // print(memmbers);

        // return result;
      } else {}
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future unitloanreport({required String from, required String to}) async {
    var map = <String, dynamic>{};

    map['from'] = from;
    map['to'] = to;
    map['type'] = typeofreport;
    map['member'] = membid.toString();
    map['presidentid'] = presidentid.toString();
    try {
      http.Response response =
          await http.post(AuthLinks.shreyasloanreport, body: map);
      if (response.body.contains('loandata')) {
        var data = jsonDecode(response.body);

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

  List<String> savingsdata = [];
  String savingsAmount = '0';
  setSavingsAmount(value) {
    savingsAmount = value;
    notifyListeners();
  }

  String monthlyCollectionAmount = '0';
  setmonthlyCollectionAmount(value) {
    monthlyCollectionAmount = value;
    notifyListeners();
  }

  addsavingsdata({required String id}) {
    /* 
    Map<String, dynamic> maps = <String, dynamic>{};
    maps['id'] = id; */
    if (savingsdata.toString().contains(id)) {
      savingsdata.removeWhere((element) => element == id);
      // val.remove({'id': id});
    } else {
      // savingsdata.insert(int.parse(id), savingsAmount);
      savingsdata.add(savingsAmount);
    }

    // print(savingsdata);

    notifyListeners();
  }

  addExpense(
      {required String reason,
      required String amount,
      required String accountinghead,
      required String date,
      required BuildContext context}) async {
    ProgressDialog.show(context: context, status: 'Adding Expense');
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['date'] = date;
    map['reason'] = reason;
    map['amount'] = amount;
    map['acchead'] = accountinghead;

    try {
      http.Response response = await http.post(AuthLinks.expense, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'Expense added successfully');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);

        Fluttertoast.showToast(msg: 'Failed to add expense');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else {
        ProgressDialog.hide(context);

        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      print(e);
    }
    ProgressDialog.hide(context);

    notifyListeners();
  }

  payUnit({required String date, required BuildContext context}) async {
    ProgressDialog.show(context: context, status: 'Please wait');
    var map = <String, dynamic>{};
    map['passbookno'] = passbookno;
    map['date'] = date;
    map['amount'] = payunitAmount.toString();

    try {
      http.Response response =
          await http.post(AuthLinks.presunitpay, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'success');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);

        Fluttertoast.showToast(msg: 'Failed');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else {
        ProgressDialog.hide(context);

        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      print(e);
    }
    ProgressDialog.hide(context);

    notifyListeners();
  }

  paySessToUnit({required String date, required BuildContext context}) async {
    ProgressDialog.show(context: context, status: 'Please wait');
    var map = <String, dynamic>{};
    map['passbookno'] = passbookno;
    map['date'] = date;
    map['amount'] = paysessAmount.toString();

    try {
      http.Response response =
          await http.post(AuthLinks.presidentPaysessfund, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);
        Fluttertoast.showToast(msg: 'success');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);

        Fluttertoast.showToast(msg: 'Failed');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else {
        ProgressDialog.hide(context);

        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      print(e);
    }
    ProgressDialog.hide(context);

    notifyListeners();
  }

  updatePresidentPassword(
      {required String newpassword, required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ProgressDialog.show(context: context, status: 'Please wait');
    var map = <String, dynamic>{};
    map['passbookno'] = passbookno;
    map['npass'] = newpassword;

    try {
      http.Response response =
          await http.post(AuthLinks.updatePressidentPassword, body: map);
      if (response.body
          .contains("You have successfully changed your password!!!!")) {
        await prefs.setString('ppassword', newpassword);
        ProgressDialog.hide(context);
        Fluttertoast.showToast(
            msg: "You have successfully changed your password!!!!");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Failed')) {
        ProgressDialog.hide(context);

        Fluttertoast.showToast(msg: 'Failed');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else {
        ProgressDialog.hide(context);

        Fluttertoast.showToast(msg: 'something went wrong');
      }
    } catch (e) {
      print(e);
    }
    ProgressDialog.hide(context);

    notifyListeners();
  }

//variables
/*   String savingsReport = '0';
  String attendanceReport = '0';
  String sessfundReport = '0';
  String festivalfundReport = '0';
  String loanReport = '0';
  String expenseReport = '0'; */
  bool showsavingsReport = false;
  bool showattendanceReport = false;
  bool showsessfundReport = false;
  bool showfestivalfundReport = false;
  bool showloanReport = false;
  bool showexpenseReport = false;
  setSavingsReport() {
    showsavingsReport = true;
    showattendanceReport = false;
    showsessfundReport = false;
    showfestivalfundReport = false;
    showloanReport = false;
    showexpenseReport = false;
    notifyListeners();
  }

  setattendanceReport() {
    showsavingsReport = false;
    showattendanceReport = true;
    showsessfundReport = false;
    showfestivalfundReport = false;
    showloanReport = false;
    showexpenseReport = false;
    notifyListeners();
  }

  setsessfundReport() {
    showsavingsReport = false;
    showattendanceReport = false;
    showsessfundReport = true;
    showfestivalfundReport = false;
    showloanReport = false;
    showexpenseReport = false;
    notifyListeners();
  }

  setfestivalfundReport() {
    showsavingsReport = false;
    showattendanceReport = false;
    showsessfundReport = false;
    showfestivalfundReport = true;
    showloanReport = false;
    showexpenseReport = false;
    notifyListeners();
  }

  setloanReport() {
    showsavingsReport = false;
    showattendanceReport = false;
    showsessfundReport = false;
    showfestivalfundReport = false;
    showloanReport = true;
    showexpenseReport = false;
    notifyListeners();
  }

  setexpenseReport() {
    showsavingsReport = false;
    showattendanceReport = false;
    showsessfundReport = false;
    showfestivalfundReport = false;
    showloanReport = false;
    showexpenseReport = true;
    notifyListeners();
  }

//sambadhyam savigs not working
  List<Map<String, dynamic>> abc = [];
  demoaddSavings(String id) {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['amt'] = savingsAmount;
    abc.add(map);
  }

  List<String> ab = ['150', '200', '0', '400', '400', '50', '0'];
  Future addsambhadyam(BuildContext context) async {
    DateTime today = DateTime.now();

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(today);
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['date'] = date;
    map['memberdata'] = {'id': '40', 'amt': '200'}.toString(); // ab.toString();
    try {
      http.Response response =
          await http.post(AuthLinks.addsambhadyam, body: map);
      if (response.body.contains('Success')) {
        Fluttertoast.showToast(msg: 'Savings added successfully');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Already added')) {
        Fluttertoast.showToast(msg: 'Already added');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
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

  Future addfestivalfund(BuildContext context) async {
    DateTime today = DateTime.now();

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(today);
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['date'] = date;
    map['memberdata'] = {'id': '40', 'amt': '200'}.toString(); // ab.toString();
    try {
      http.Response response =
          await http.post(AuthLinks.addPFestivalfund, body: map);
      if (response.body.contains('Success')) {
        Fluttertoast.showToast(msg: 'added successfully');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Already added')) {
        Fluttertoast.showToast(msg: 'Already added');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
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

  Future viewGrant() async {
    var map = <String, dynamic>{};
    map['passbookno'] = passbookno;

    try {
      http.Response response = await http.post(AuthLinks.viewgrant, body: map);
      if (response.body.contains('grantdata')) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  String memberpassbook = '';
  setMemberpassbook(val) {
    memberpassbook = val;
    notifyListeners();
  }

  Future tranferGeanttoMember(
      {required grantid,
      required transferdate,
      required type,
      required amount,
      required BuildContext context}) async {
    var map = <String, dynamic>{};
    map['grantid'] = grantid;
    map['transferdate'] = transferdate;
    map['type'] = type;
    map['amount'] = amount;
    map['memberpassbookno'] = memberpassbook;
    map['shgpassbookno'] = passbookno;

    try {
      http.Response response =
          await http.post(AuthLinks.transfergrantunit, body: map);
      if (response.body.contains('Grant Transfered')) {
        Fluttertoast.showToast(msg: 'Grant Transfered successfully');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Already added')) {
        Fluttertoast.showToast(msg: 'Already added');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
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

  String shgloanamount = '0';
  String shgloanperiod = '0';
  String shgloaninterest = '0';
  String shgloanpaymentdate = '0';
  setshgloanamt(value) {
    shgloanamount = value;
    notifyListeners();
  }

  setshgloanperiod(val) {
    shgloanperiod = val;
    notifyListeners();
  }

  setshgloaninterest(val) {
    shgloaninterest = val;
    notifyListeners();
  }

  setshgloanpaydate(val) {
    shgloanpaymentdate = val;
    notifyListeners();
  }

  Future giveshgloan(String id, String membername, BuildContext context) async {
    DateTime today = DateTime.now();

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(today);
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['date'] = date;
    map['amount'] = shgloanamount;
    map['period'] = shgloanperiod;
    map['interest'] = shgloaninterest;
    map['id'] = id;
    map['pdate'] = shgloanpaymentdate;
    try {
      http.Response response =
          await http.post(AuthLinks.shgloanPres, body: map);
      if (response.body.contains('Success')) {
        Fluttertoast.showToast(msg: 'Loan added successfully');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Already added')) {
        Fluttertoast.showToast(msg: 'Loan already added');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
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

  String bankLoanamount = '0';
  String bankLoanperiod = '0';
  String bankLoaninterest = '0';
  String bankLoanpaymentdate = '0';
  setbankLoanamt(value) {
    bankLoanamount = value;
    notifyListeners();
  }

  setbankLoanperiod(val) {
    bankLoanperiod = val;
    notifyListeners();
  }

  setbankLoaninterest(val) {
    bankLoaninterest = val;
    notifyListeners();
  }

  setbankLoanpaydate(val) {
    bankLoanpaymentdate = val;
    notifyListeners();
  }

  giveBankloan({required BuildContext context, required String id}) async {
    DateTime today = DateTime.now();

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(today);
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['date'] = date;
    map['amount'] = bankLoanamount;
    map['period'] = bankLoanperiod;
    map['interest'] = bankLoaninterest;
    map['id'] = id;
    map['pdate'] = bankLoanpaymentdate;
    try {
      http.Response response =
          await http.post(AuthLinks.shgloanPres, body: map);
      if (response.body.contains('Success')) {
        Fluttertoast.showToast(msg: 'Loan added successfully');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Already added')) {
        Fluttertoast.showToast(msg: 'Loan already added');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
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

  addPExternalMember(BuildContext context,
      {required String number, required String mailid}) async {
    ProgressDialog.show(context: context, status: 'Adding Member');
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['phone'] = number;
    map['mail'] = mailid;
    map['group'] = 'Non Shg Member';
    map['shg'] = presidentid;
    map['unit'] = unitname;
    try {
      http.Response response =
          await http.post(AuthLinks.pAddExternalMember, body: map);
      if (response.body.contains('Success')) {
        ProgressDialog.hide(context);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
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

  Future getExternalMembers() async {
    var map = <String, dynamic>{};

    map['shgid'] = presidentid;
    try {
      http.Response response =
          await http.post(AuthLinks.getexternalmember, body: map);
      if (response.body.contains('memberdata')) {
        var data = jsonDecode(response.body);

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

  List<DropDownValueModel> income = [];
  List<DropDownValueModel> expense = [];
  Future getPresidentAccountingHead() async {
    var map = <String, dynamic>{};

    map['passbookno'] = passbookno;
    try {
      http.Response response =
          await http.post(AuthLinks.getPresidentaccountinghead, body: map);
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

  String externalLoanamount = '0';
  String externalLoanperiod = '0';
  String externalLoaninterest = '0';
  String externalLoanpaymentdate = '0';
  setexternalLoanamt(value) {
    externalLoanamount = value;
    notifyListeners();
  }

  setexternalLoanperiod(val) {
    externalLoanperiod = val;
    notifyListeners();
  }

  setexternalLoaninterest(val) {
    externalLoaninterest = val;
    notifyListeners();
  }

  setexternalLoanpaydate(val) {
    externalLoanpaymentdate = val;
    notifyListeners();
  }

  Future giveExternalLoan(String id, BuildContext context) async {
    DateTime today = DateTime.now();

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String date = formatter.format(today);
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['date'] = date;
    map['amount'] = externalLoanamount;
    map['period'] = externalLoanperiod;
    map['interest'] = externalLoaninterest;
    map['id'] = id;
    map['status'] = 'non member';
    map['pdate'] = externalLoanpaymentdate;
    try {
      http.Response response =
          await http.post(AuthLinks.giveexternalLoan, body: map);
      if (response.body.contains('Success')) {
        Fluttertoast.showToast(msg: 'Loan added successfully');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
            ),
            (route) => false);
      } else if (response.body.contains('Already added')) {
        Fluttertoast.showToast(msg: 'Loan already added');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const PresidentHome(),
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

  Future changePresident(BuildContext context, String? memberid) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['presidentid'] = presidentid;
    map['memberid'] = memberid;

    try {
      http.Response response =
          await http.post(AuthLinks.changePresident, body: map);
      if (response.body.contains('Success')) {
        Fluttertoast.showToast(msg: 'successfully changed president');
        await getDataa(context);
        ProgressDialog.hide(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const SplashScreen(),
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

  Future addAccountingHead(
      BuildContext context, String? type, String? accountinghead) async {
    ProgressDialog.show(context: context, status: 'Please Wait');
    var map = <String, dynamic>{};
    map['passbookno'] = passbookno;
    map['accountinghead'] = accountinghead;
    map['type'] = type;

    try {
      http.Response response =
          await http.post(AuthLinks.addaccountingheadPres, body: map);
      if (response.body.contains('Accounting head added')) {
        Fluttertoast.showToast(msg: 'successfully added');
        await getPresidentAccountingHead();
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

  Future getSHGLoanDetails() async {
    var map = <String, dynamic>{};

    map['presidentid'] = presidentid;
    try {
      http.Response response =
          await http.post(AuthLinks.presshgloandata, body: map);
      if (response.body.contains('loandata')) {
        var data = jsonDecode(response.body);
        return data;
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

  Future presidentshgloanIntpaymentdet() async {
    var map = <String, dynamic>{};

    map['memberid'] = memberid; //'178'; //
    try {
      http.Response response =
          await http.post(AuthLinks.presshgloanIntPaymentdet, body: map);
      if (response.body.contains('loandata')) {
        var data = jsonDecode(response.body);

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

  bool intresest = true;
  bool amount = false;
  setinterestclicked() {
    amount = false;
    intresest = true;

    notifyListeners();
  }

  setamountclicked() {
    intresest = false;
    amount = true;

    notifyListeners();
  }

  Future getPresidentShgloanPaymentDet() async {
    var map = <String, dynamic>{};

    map['memberid'] = memberid; // '178'; // memberid;
    try {
      http.Response response =
          await http.post(AuthLinks.shgloanamountpaymentdetails, body: map);
      if (response.body.contains('loanid')) {
        var data = jsonDecode(response.body);

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

  Future getPresidentUnitLoanData() async {
    var map = <String, dynamic>{};

    map['presidentid'] = presidentid;
    try {
      http.Response response =
          await http.post(AuthLinks.shgunitloandata, body: map);
      if (response.body.contains('loandata')) {
        var data = jsonDecode(response.body);
        return data;
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

  Future presidentunitLoanInterestPaymentData() async {
    var map = <String, dynamic>{};

    map['presidentid'] = presidentid;
    try {
      http.Response response = await http
          .post(AuthLinks.presidentunitloaninterestpayment, body: map);
      if (response.body.contains('loandata')) {
        var data = jsonDecode(response.body);

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

  Future presidentunitLoanPayment() async {
    var map = <String, dynamic>{};

    map['presidentid'] = presidentid;
    try {
      http.Response response =
          await http.post(AuthLinks.presunitloanpaymentdata, body: map);
      if (response.body.contains('loanid')) {
        var data = jsonDecode(response.body);

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

  logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Fluttertoast.showToast(msg: 'Yahooo !!!');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx) => const SplashScreen(),
        ),
        (route) => false);
  }
}
