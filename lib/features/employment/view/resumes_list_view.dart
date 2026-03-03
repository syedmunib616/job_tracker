import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_tracker/features/employment/view_models/resumes_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumesListView extends ConsumerWidget {
  const ResumesListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumesAsync = ref.watch(resumesStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Resumes')),
      body: resumesAsync.when(
        data: (resumes) {
          if (resumes.isEmpty) return const Center(child: Text('No resumes uploaded.'));
          return ListView.builder(
            itemCount: resumes.length,
            itemBuilder: (context, index) {
              final resume = resumes[index];
              return ListTile(
                title: Text(resume['fileName']),
                subtitle: Text(resume['uploadedAt'] != null
                    ? (resume['uploadedAt'] as Timestamp).toDate().toString()
                    : ''),
                trailing: IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () async {
                    final url = resume['fileUrl'];
                    final uri = Uri.parse(url);

                    try {
                      // Directly launch without canLaunchUrl
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    } catch (e) {
                      print("$e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Could not open file: $e')),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}