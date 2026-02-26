
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:job_tracker/core/services/job_service.dart';
import '../../../core/services/firestore_service.dart';
import '../models/job_model.dart';

// Firestore provider
final firestoreProvider = Provider((ref) => JobService());

// Job ViewModel
class JobViewModel extends StateNotifier<bool> {
  final JobService _firestore;
  JobViewModel(this._firestore) : super(false);

  Future<void> addJob({
    required String company,
    required String role,
    required String location,
    required String status,
    required double salary,
    required String notes,
  }) async {
    state = true;

    final uid = FirebaseAuth.instance.currentUser!.uid;

    final job = JobModel(
      id: "",
      company: company,
      role: role,
      location: location,
      status: status,
      salary: salary,
      notes: notes,
      createdAt: DateTime.now(),
    );

    await _firestore.addJob(uid, job);
    state = false;
  }

  Future<void> deleteJob(String jobId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.deleteJob(uid, jobId);
  }

  Future<void> updateJob(String jobId, JobModel job) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.updateJob(uid, jobId, job.toJson());
  }


}

final jobViewModelProvider =
StateNotifierProvider<JobViewModel, bool>((ref) {
  return JobViewModel(ref.read(firestoreProvider));
});

// Live Jobs Stream Provider
final jobsProvider = StreamProvider((ref) {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  return ref.read(firestoreProvider).getJobs(uid);
});



// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/services/job_service.dart';
// import '../models/job_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// final jobServiceProvider = Provider((ref) => JobService());
//
// final jobViewModelProvider = Provider((ref) {
//   return JobViewModel(ref.read(jobServiceProvider));
// });
//
// class JobViewModel {
//   final JobService _service;
//   JobViewModel(this._service);
//
//   String get uid => FirebaseAuth.instance.currentUser!.uid;
//
//   Future<void> addJob(JobModel job) async {
//     await _service.addJob(uid, job);
//   }
//
//   Stream<List<JobModel>> getJobs() {
//     return _service.streamJobs(uid);
//   }
//
//   Future<void> updateJob(JobModel job) async {
//     await _service.updateJob(uid, job);
//   }
//
//   Future<void> deleteJob(String jobId) async {
//     await _service.deleteJob(uid, jobId);
//   }
// }