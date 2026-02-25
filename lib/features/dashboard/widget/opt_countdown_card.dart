import 'package:flutter/material.dart';

// class OptCountdownCard extends StatelessWidget {
//   const OptCountdownCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Card(
//       elevation: theme.brightness == Brightness.dark ? 2 : 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '90 Days Rule Tracker',
//                   style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
//                 ),
//                 Chip(
//                   label: const Text('Active'),
//                   backgroundColor: Colors.green.withOpacity(0.15),
//                   labelStyle: const TextStyle(color: Colors.green),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             _InfoRow(label: 'Start Date', value: 'May 20, 2026'),
//             const SizedBox(height: 12),
//             _InfoRow(
//               label: 'Days Left',
//               value: '65',
//               valueStyle: TextStyle(
//                 color: Colors.green.shade700,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//             const SizedBox(height: 12),
//             _InfoRow(label: 'Unemployment Used', value: '15 days'),
//             const SizedBox(height: 16),
//             LinearProgressIndicator(
//               value: 15 / 90,
//               backgroundColor: Colors.grey[300],
//               minHeight: 8,
//               borderRadius: BorderRadius.circular(4),
//             ),
//             const SizedBox(height: 8),
//             Text('15 / 90 days used', style: theme.textTheme.bodySmall),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:job_tracker/features/opt/opt_model/opt_model.dart';

class OptCountdownCard extends StatelessWidget {
  final OptModel opt;

  const OptCountdownCard({super.key, required this.opt});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final totalDays = 90; // OPT unemployment limit
    final usedDays = opt.unemploymentDaysUsed;
    final daysLeft = opt.optEndDate.difference(DateTime.now()).inDays;

    return Card(
      elevation: theme.brightness == Brightness.dark ? 2 : 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                  label: Text(daysLeft > 0 ? "Active" : "Expired"),
                  backgroundColor:
                  daysLeft > 0 ? Colors.green.withOpacity(0.15) : Colors.red.withOpacity(0.15),
                  labelStyle: TextStyle(
                    color: daysLeft > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            _InfoRow(
              label: 'Start Date',
              value: opt.optStartDate.toLocal().toString().split(" ")[0],
            ),

            const SizedBox(height: 12),

            _InfoRow(
              label: 'Days Left',
              value: "$daysLeft",
              valueStyle: TextStyle(
                color: daysLeft > 0 ? Colors.green.shade700 : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 12),

            _InfoRow(
              label: 'Unemployment Used',
              value: "$usedDays days",
            ),

            const SizedBox(height: 16),

            LinearProgressIndicator(
              value: usedDays / totalDays,
              backgroundColor: Colors.grey[300],
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),

            const SizedBox(height: 8),

            Text(
              "$usedDays / $totalDays days used",
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

// Keep reusable
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? valueStyle;

  const _InfoRow({
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: valueStyle ??
              Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
// Keep _InfoRow here or move to shared/widgets if reused often
// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;
//   final TextStyle? valueStyle;
//
//   const _InfoRow({required this.label, required this.value, this.valueStyle});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//             color: Theme.of(context).colorScheme.onSurfaceVariant,
//           ),
//         ),
//         Text(
//           value,
//           style: valueStyle ??
//               Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
//         ),
//       ],
//     );
//   }
// }