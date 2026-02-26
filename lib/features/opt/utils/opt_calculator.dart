


import 'package:job_tracker/features/employment/models/employment_model.dart';

class OptCalculator {
  static int calculateUnemploymentDays({
    required DateTime optStartDate,
    required List<EmploymentModel> employments,
  }) {
    final today = DateTime.now();

    // Total days since OPT started
    int totalDays = today.difference(optStartDate).inDays;

    if (totalDays < 0) return 0;

    int totalEmploymentDays = 0;

    for (var job in employments) {
      DateTime jobStart = job.startDate;
      DateTime jobEnd = job.endDate ?? today;

      // Ignore jobs before OPT start
      if (jobEnd.isBefore(optStartDate)) continue;

      if (jobStart.isBefore(optStartDate)) {
        jobStart = optStartDate;
      }

      totalEmploymentDays +=
          jobEnd.difference(jobStart).inDays;
    }

    int unemployment = totalDays - totalEmploymentDays;

    if (unemployment < 0) return 0;
    if (unemployment > 90) return 90;

    return unemployment;
  }
}