import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/jobs/models/job_model.dart';

class JobService {
  final _db = FirebaseFirestore.instance;

  // final _db = FirebaseFirestore.instance;

  Future<void> addJob(String uid, JobModel job) async {
    await _db.collection("users").doc(uid).collection("jobs").add(job.toJson());
  }

  Stream<List<JobModel>> getJobs(String uid) {
    return _db
        .collection("users")
        .doc(uid)
        .collection("jobs")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => JobModel.fromFirestore(doc)).toList());
  }

  // Stream Jobs
  Stream<List<JobModel>> streamJobs(String uid) {
    return _db
        .collection("users")
        .doc(uid)
        .collection("jobs")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => JobModel.fromFirestore(doc)).toList();
    });
  }

  Future<void> deleteJob(String uid, String jobId) async {
    await _db
        .collection("users")
        .doc(uid)
        .collection("jobs")
        .doc(jobId)
        .delete();
  }

  Future<void> updateJob(String uid, String jobId, Map<String, dynamic> data) async {
    await _db
        .collection("users")
        .doc(uid)
        .collection("jobs")
        .doc(jobId)
        .update(data);
  }
}