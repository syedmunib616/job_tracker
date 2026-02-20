import 'package:flutter/material.dart';

class RecentApplicationsCard extends StatelessWidget {
  const RecentApplicationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: theme.brightness == Brightness.dark ? 2 : 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: const [
          _ApplicationTile(company: 'Google', status: 'Applied', statusColor: Colors.blue),
          Divider(height: 1),
          _ApplicationTile(company: 'Amazon', status: 'Interview', statusColor: Colors.orange),
          Divider(height: 1),
          _ApplicationTile(company: 'Meta', status: 'Rejected', statusColor: Colors.red),
        ],
      ),
    );
  }
}

class _ApplicationTile extends StatelessWidget {
  final String company;
  final String status;
  final Color statusColor;

  const _ApplicationTile({
    required this.company,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: statusColor.withOpacity(0.15),
        child: Icon(Icons.work_outline, color: statusColor),
      ),
      title: Text(company, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          status,
          style: TextStyle(color: statusColor, fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ),
    );
  }
}