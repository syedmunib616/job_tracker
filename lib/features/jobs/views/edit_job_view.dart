import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/job_model.dart';
import '../view_models/job_view_model.dart';

class EditJobView extends ConsumerStatefulWidget {
  final JobModel job;
  const EditJobView({super.key, required this.job});

  @override
  ConsumerState<EditJobView> createState() => _EditJobViewState();
}

class _EditJobViewState extends ConsumerState<EditJobView> {
  late TextEditingController company;
  late TextEditingController role;
  late TextEditingController location;
  late TextEditingController salary;
  late TextEditingController notes;

  late String status;

  @override
  void initState() {
    super.initState();
    company = TextEditingController(text: widget.job.company);
    role = TextEditingController(text: widget.job.role);
    location = TextEditingController(text: widget.job.location);
    salary = TextEditingController(text: widget.job.salary.toString());
    notes = TextEditingController(text: widget.job.notes);
    status = widget.job.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Job")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _field(company, "Company"),
            _field(role, "Role"),
            _field(location, "Location"),
            _field(salary, "Salary", number: true),

            DropdownButtonFormField(
              value: status,
              items: ["Applied", "Interview", "Offer", "Rejected"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => status = v!),
              decoration: InputDecoration(
                labelText: "Status",
                prefixIcon: const Icon(Icons.flag),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            _field(notes, "Notes"),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final updated = JobModel(
                  id: widget.job.id,
                  company: company.text,
                  role: role.text,
                  location: location.text,
                  status: status,
                  salary: double.tryParse(salary.text) ?? 0,
                  notes: notes.text,
                  createdAt: widget.job.createdAt,
                );

                await ref
                    .read(jobViewModelProvider.notifier)
                    .updateJob(widget.job.id, updated);

                Navigator.pop(context);
              },
              child: const Text("Update Job"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label,
      {bool number = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}