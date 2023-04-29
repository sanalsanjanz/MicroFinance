import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';

class UnitAddShgLoan extends StatefulWidget {
  const UnitAddShgLoan({super.key});

  @override
  State<UnitAddShgLoan> createState() => _UnitAddShgLoanState();
}

class _UnitAddShgLoanState extends State<UnitAddShgLoan> {
  @override
  void initState() {
    super.initState();
    Provider.of<UnitControll>(context, listen: false)
        .getallSHG(context: context, opt: 2);
  }

  TextEditingController loanAmountController = TextEditingController();
  TextEditingController loanPeriodController = TextEditingController();
  TextEditingController loanInterestController = TextEditingController();
  TextEditingController loanPaymentDateController = TextEditingController();
  String shgPassbook = '';
  @override
  Widget build(BuildContext context) {
    Widget spacer = const Center(child: Text(':    '));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryUnitColor,
        title: const Text('Unit Loan to SGH'),
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
                            shgPassbook = value.value;
                          },
                          dropDownList: myType.shglist);
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
                            suffixIcon: Icon(Icons.currency_exchange_outlined)),
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
                        controller: loanInterestController,
                        //onChanged: (value) => val.setshgloaninterest(value),
                        decoration: const InputDecoration(
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
                            await val.addUnitLoantoSHG(
                                context,
                                loanAmountController.text,
                                loanPeriodController.text,
                                shgPassbook);
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
