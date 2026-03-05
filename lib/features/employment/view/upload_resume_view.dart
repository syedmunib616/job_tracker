import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/core/widget/button.dart';
import '../view_models/employment_view_model.dart';

class UploadResumeView extends ConsumerWidget {
  const UploadResumeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(employmentViewModelProvider);
    final viewModel = ref.read(employmentViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Upload Resume')),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            :
        AppButton(
          width: 200,
          text: 'Upload Resume',
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf', 'doc', 'docx'],
            );

            if (result != null && result.files.single.path != null) {
              final file = File(result.files.single.path!);

              final fileSize = await file.length();

              if (fileSize > 300 * 1024) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('File must be smaller than 300 KB'),
                  ),
                );
                return;
              }

              await viewModel.uploadResume(file);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Resume uploaded successfully!')),
              );
            }
          },
          icon: Icons.upload_file,
        ),
      ),
    );
  }
}