import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/unit/views/unitHome.dart';

class AddUnitIndividualLoan extends StatefulWidget {
  AddUnitIndividualLoan({super.key, required this.shgpassbook});
  String shgpassbook;
  @override
  State<AddUnitIndividualLoan> createState() => _AddUnitIndividualLoanState();
}

class _AddUnitIndividualLoanState extends State<AddUnitIndividualLoan> {
  @override
  void initState() {
    super.initState();
    Provider.of<UnitControll>(context, listen: false)
        .getSHGMembers(shgpassbook: widget.shgpassbook);
  }

  TextEditingController loanAmountController = TextEditingController();
  TextEditingController loanPeriodController = TextEditingController();
  TextEditingController loanInterestController = TextEditingController();
  TextEditingController loanPaymentDateController = TextEditingController();
  String memberpassbookno = '';
  @override
  Widget build(BuildContext context) {
    Widget spacer = const Center(child: Text(':    '));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (ctx) => const UnitHome(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: primaryUnitColor,
        title: const Text('Unit Loan to Individuals'),
      ),
      body: Column(
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Consumer<UnitControll>(
                    builder: (context, myType, child) {
                      return DropDownTextField(
                          onChanged: (value) {
                            memberpassbookno = value.value;
                          },
                          dropDownList: myType.shgMemberList);
                    },
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Expanded(child: Text('Loan Amount')),
                      spacer,
                      Expanded(
                          child: TextField(
                        controller: loanAmountController,
                        //onChanged: (value) => val.setshgloanamt(value),
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.currency_exchange_outlined),
                        ),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text('Loan Period')),
                      spacer,
                      Expanded(
                          child: TextField(
                        controller: loanPeriodController,
                        //onChanged: (value) => val.setshgloanperiod(value),
                        decoration:
                            const InputDecoration(suffix: Text('/months')),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child: Text('Interest')),
                      spacer,
                      Expanded(
                          child: TextField(
                        readOnly: true,
                        controller: loanInterestController,
                        //onChanged: (value) => val.setshgloaninterest(value),
                        decoration: const InputDecoration(
                            hintText: '12/year',
                            suffixIcon: Icon(Icons.percent)),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text('Payment Date'),
                      ),
                      spacer,
                      Expanded(
                          child: TextField(
                        controller: loanPaymentDateController,
                        //onChanged: (value) => val.setshgloanpaydate(value),
                        decoration: const InputDecoration(hintText: '(1-31)'),
                      ))
                    ],
                  ),
                  const Divider(),
                  Consumer<UnitControll>(
                    builder: (context, val, child) {
                      return CupertinoButton(
                          child: const Text('GIVE LOAN'),
                          onPressed: () async {
                            await val.addUnitIndLoan(
                                context: context,
                                amount: loanAmountController.text,
                                period: loanPeriodController.text,
                                memberpassbookno: memberpassbookno,
                                shgpassbookno: widget.shgpassbook,
                                date: loanPaymentDateController.text);
                            /*  await val.addUnitLoantoSHG(
                                context,
                                loanAmountController.text,
                                loanPeriodController.text,
                                shgPassbook); */
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
