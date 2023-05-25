import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';

class RegionalAddProject extends StatelessWidget {
  RegionalAddProject({super.key});
  final TextEditingController projectName = TextEditingController();
  final TextEditingController agencyName = TextEditingController();
  final TextEditingController estimate = TextEditingController();
  final TextEditingController area = TextEditingController();
  final TextEditingController purpose = TextEditingController();
  final TextEditingController duration = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 8),
            TextField(
              controller: projectName,
              decoration: const InputDecoration(hintText: 'Enter project name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: agencyName,
              decoration: const InputDecoration(hintText: 'Enter agency name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: estimate,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Estimate'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: area,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Area'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: purpose,
              decoration: const InputDecoration(hintText: 'Purpose'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: duration,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Duration'),
            ),
            const SizedBox(height: 8),
            Consumer<RegionalController>(
              builder: (context, myType, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRegionColor),
                  onPressed: () async {
                    await myType.regionalAddProject(
                        context: context,
                        projectname: projectName.text,
                        fundingagency: agencyName.text,
                        estimate: estimate.text,
                        area: area.text,
                        purpose: purpose.text,
                        duration: duration.text);
                  },
                  child: const Text('Add Project'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
