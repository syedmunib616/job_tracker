import 'package:flutter/material.dart';
import 'package:job_tracker/features/employment/models/employment_model.dart';
import 'package:job_tracker/features/opt/opt_model/opt_model.dart';
import 'package:job_tracker/features/opt/utils/opt_calculator.dart';
import 'package:job_tracker/features/opt/widget/info_row.dart';

class OptCountdownCard extends StatelessWidget {
  final OptModel opt;
  final List<EmploymentModel> employments;

  const OptCountdownCard({super.key, required this.opt, required this.employments});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);



    final usedDays = OptCalculator.calculateUnemploymentDays(
      optStartDate: opt.optStartDate,
      employments: employments,
    );

    const totalDays = 90;
    final unemploymentDaysLeft = totalDays - usedDays;

    final optDaysLeft =
        opt.optEndDate.difference(DateTime.now()).inDays;

    final isActive = optDaysLeft > 0;

    Color progressColor;
    if (unemploymentDaysLeft <= 10) {
      progressColor = Colors.red;
    } else if (unemploymentDaysLeft <= 30) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.green;
    }

    print("????????? $totalDays ???? $usedDays ");
    return Card(
      elevation: theme.brightness == Brightness.dark ? 2 : 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '90 Days Rule Tracker',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Chip(
                  label: Text(isActive ? "Active" : "Expired"),
                  backgroundColor: isActive
                      ? Colors.green.withOpacity(0.15)
                      : Colors.red.withOpacity(0.15),
                  labelStyle: TextStyle(
                    color: isActive ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            InfoRow(
              label: 'OPT Start',
              value: opt.optStartDate
                  .toLocal()
                  .toString()
                  .split(" ")[0],
            ),

            const SizedBox(height: 12),

            InfoRow(
              label: 'OPT Days Left',
              value: "$optDaysLeft",
              valueStyle: TextStyle(
                color: isActive
                    ? Colors.green.shade700
                    : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 12),

            InfoRow(
              label: 'Unemployment Used',
              value: "$usedDays days",
            ),

            const SizedBox(height: 12),

            InfoRow(
              label: 'Unemployment Remaining',
              value: "$unemploymentDaysLeft days",
              valueStyle: TextStyle(
                color: progressColor,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            LinearProgressIndicator(
              value: usedDays / totalDays,
              color: progressColor,
              backgroundColor: Colors.grey[300],
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),

            const SizedBox(height: 8),

            Text(
              "$usedDays / $totalDays unemployment days used",
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );

  }
}