// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidentConfigController.dart';
import 'package:sacco_management/widgets/choiceChip.dart';

class PresidentConfig extends StatefulWidget {
  const PresidentConfig({super.key});

  @override
  State<PresidentConfig> createState() => _PresidentConfigState();
}

class _PresidentConfigState extends State<PresidentConfig> {
  @override
  void initState() {
    super.initState();
    Provider.of<PresidentConfigController>(context, listen: false)
        .getPresidentConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuation '),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PresidentConfigController>(builder: (context, val, ch) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(
                color: Colors.transparent,
              ),
              const Text(
                "Select the features that you have providing",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const Divider(
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomChoiceChip(
                      isSelected: val.festivafund,
                      onSelected: (onSelected) {
                        val.setFestivalfund();
                      },
                      label: 'Festival Fund'),
                  CustomChoiceChip(
                      isSelected: val.banklinkage,
                      onSelected: (onSelected) {
                        val.setBankLinkage();
                      },
                      label: 'Bank Linkage')
                ],
              ),
              const Divider(
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomChoiceChip(
                      isSelected: val.insurance,
                      onSelected: (onSelected) {
                        val.setInsurance();
                      },
                      label: 'Insurance'),
                  CustomChoiceChip(
                      isSelected: val.grant,
                      onSelected: (onSelected) {
                        val.setGrant();
                      },
                      label: 'Grant'),
                  CustomChoiceChip(
                      isSelected: val.sessfund,
                      onSelected: (onSelected) {
                        val.setSessfund();
                      },
                      label: 'Sess Fund')
                ],
              ),
              const Divider(
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomChoiceChip(
                      isSelected: val.medicalaid,
                      onSelected: (onSelected) {
                        val.setMedicalAid();
                      },
                      label: 'Medical Aid'),
                  CustomChoiceChip(
                      isSelected: val.profit,
                      onSelected: (onSelected) {
                        val.setProfit();
                      },
                      label: 'Profit'),
                  CustomChoiceChip(
                      isSelected: val.shares,
                      onSelected: (onSelected) {
                        val.setShares();
                      },
                      label: 'Shares')
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryUnitColor,
                      shape: const StadiumBorder()),
                  onPressed: () {
                    val.savePreferences(context);
                  },
                  child: const Text('SAVE PREFERENCES'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        }),
      ),
    );
  }
}
