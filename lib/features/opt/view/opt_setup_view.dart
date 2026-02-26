import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/drawer.dart';

import '../opt_model/opt_model.dart';
import '../opt_view_model/opt_view_model.dart';

class OptSetupView extends ConsumerStatefulWidget {
  const OptSetupView({super.key});

  @override
  ConsumerState<OptSetupView> createState() => _OptSetupViewState();
}

class _OptSetupViewState extends ConsumerState<OptSetupView> {
  DateTime? startDate;
  bool stemEligible = false;

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(optViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Setup OPT")),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(startDate == null
                  ? "Select OPT Start Date"
                  : startDate!.toLocal().toString().split(" ")[0]),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2035),
                  initialDate: DateTime.now(),
                );
                if (date != null) setState(() => startDate = date);
              },
            ),

            SwitchListTile(
              title: Text("STEM OPT Eligible"),
              value: stemEligible,
              onChanged: (v) => setState(() => stemEligible = v),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: loading
                  ? null
                  : () {
                if (startDate == null) return;

                final endDate =
                startDate!.add(Duration(days: 365)); // auto calc

                final opt = OptModel(
                  optStartDate: startDate!,
                  optEndDate: endDate,
                  unemploymentDaysUsed: 0,
                  stemOptEligible: stemEligible,
                );

                ref.read(optViewModelProvider.notifier).saveOpt(opt);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("OPT Saved")),
                );
              },
              child: loading
                  ? CircularProgressIndicator()
                  : Text("Save OPT"),
            ),
          ],
        ),
      ),
    );
  }
}