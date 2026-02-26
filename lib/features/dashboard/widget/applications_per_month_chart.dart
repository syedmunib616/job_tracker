

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/features/jobs/view_models/job_view_model.dart';

class ApplicationsPerMonthChart extends ConsumerWidget {
  const ApplicationsPerMonthChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(jobsProvider);

    return jobsAsync.when(
      data: (jobs) {
        if (jobs.isEmpty) {
          return const Center(child: Text("No applications yet"));
        }

        // Group jobs by month
        final Map<String, int> monthlyData = {};

        for (var job in jobs) {
          final monthKey =
              "${job.createdAt.year}-${job.createdAt.month.toString().padLeft(2, '0')}";

          monthlyData[monthKey] = (monthlyData[monthKey] ?? 0) + 1;
        }

        final sortedKeys = monthlyData.keys.toList()..sort();

        final barGroups = List.generate(sortedKeys.length, (index) {
          final count = monthlyData[sortedKeys[index]]!;

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: count.toDouble(),
                width: 18,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          );
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Applications per Month",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.3,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: barGroups,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= sortedKeys.length) {
                            return const SizedBox();
                          }

                          final label = sortedKeys[index]
                              .substring(5); // shows only month

                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(label),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
          ],
        );
      },
      loading: () =>
      const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }
}
