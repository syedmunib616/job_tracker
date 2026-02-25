import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/drawer.dart';
import 'package:job_tracker/features/jobs/widget/job_text_field.dart';
import '../view_models/job_view_model.dart';
import 'package:job_tracker/core/constants/app_colors.dart';

class AddJobView extends ConsumerStatefulWidget {
  const AddJobView({super.key});

  @override
  ConsumerState<AddJobView> createState() => _AddJobViewState();
}

class _AddJobViewState extends ConsumerState<AddJobView> {
  final company = TextEditingController();
  final role = TextEditingController();
  final location = TextEditingController();
  final salary = TextEditingController();
  final notes = TextEditingController();

  String status = "Applied";

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(jobViewModelProvider);

    return Scaffold(
      appBar: AppBar(
          leading: AppDrawer(),
          title: const Text("Add Job")
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            JobTextField(c: company,
              label: 'Company',
              icon: Icons.business,
              number: false,),
            JobTextField(
              c: role, label: 'Role', icon: Icons.work, number: false,),
            JobTextField(c: location,
              label: 'Location',
              icon: Icons.location_on,
              number: false,),
            JobTextField(c: salary,
              label: 'Salary',
              icon: Icons.monetization_on_outlined,
              number: true,),

            // _field(company, "Company", Icons.business,),
            // _field(role, "Role",Icons.work),
            // _field(location, "Location",Icons.location_on),
            // _field(salary, "Salary", number: true,Icons.monetization_on_outlined),

            DropdownButtonFormField(
              value: status,
              items: ["Applied", "Interview", "Offer", "Rejected"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => status = v!),

              decoration: InputDecoration(

                labelText: "Status",
                labelStyle: const TextStyle(color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.flag),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: AppColors.textSecondary, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            JobTextField(
              c: notes, label: 'Notes', icon: Icons.note, number: false,),


            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: loading ? null
                  : () async {
                await ref.read(jobViewModelProvider.notifier).addJob(
                  company: company.text,
                  role: role.text,
                  location: location.text,
                  status: status,
                  salary: double.tryParse(salary.text) ?? 0,
                  notes: notes.text,
                );
                Navigator.pop(context);
              },
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Save Job"),
            ),
          ],
        ),
      ),
    );
  }

}