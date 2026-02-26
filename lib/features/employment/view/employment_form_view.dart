import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/drawer.dart';
import 'package:job_tracker/features/employment/models/employment_model.dart';
import '../view_models/employment_view_model.dart';


class EmploymentFormView extends ConsumerStatefulWidget {
  final EmploymentModel? employment;

  const EmploymentFormView({super.key, this.employment});

  @override
  ConsumerState<EmploymentFormView> createState() =>
      _EmploymentFormViewState();
}

class _EmploymentFormViewState
    extends ConsumerState<EmploymentFormView> {
  final companyController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    if (widget.employment != null) {
      companyController.text =
          widget.employment!.companyName;
      startDate = widget.employment!.startDate;
      endDate = widget.employment!.endDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading =
    ref.watch(employmentViewModelProvider);

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.employment == null
              ? "Add Employment"
              : "Edit Employment")),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: companyController,
              decoration:
              const InputDecoration(labelText: "Company"),
            ),

            const SizedBox(height: 10),

            ListTile(
              title: Text(startDate == null
                  ? "Select Start Date"
                  : startDate!
                  .toLocal()
                  .toString()
                  .split(" ")[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2035),
                  initialDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() => startDate = picked);
                }
              },
            ),

            ListTile(
              title: Text(endDate == null
                  ? "Currently Working"
                  : endDate!
                  .toLocal()
                  .toString()
                  .split(" ")[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2035),
                  initialDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() => endDate = picked);
                }
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: loading
                  ? null
                  : () async {
                if (companyController.text.isEmpty ||
                    startDate == null) return;

                final employment = EmploymentModel(
                  id: widget.employment?.id ?? "",
                  companyName:
                  companyController.text,
                  startDate: startDate!,
                  endDate: endDate,
                );

                if (widget.employment == null) {
                  await ref
                      .read(
                      employmentViewModelProvider
                          .notifier)
                      .addEmployment(employment);
                } else {
                  await ref
                      .read(
                      employmentViewModelProvider
                          .notifier)
                      .updateEmployment(employment);
                }

                Navigator.pop(context);
              },
              child: loading
                  ? const CircularProgressIndicator()
                  : Text(widget.employment == null
                  ? "Save"
                  : "Update"),
            )
          ],
        ),
      ),
    );
  }
}