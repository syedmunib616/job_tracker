import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_tracker/features/employment/models/employment_model.dart';

class EmploymentService {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference _collection(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("employmentPeriods");
  }

  Future<void> addEmployment(
      String uid, EmploymentModel employment) async {
    await _collection(uid).add(employment.toMap());
  }

  Future<void> updateEmployment(
      String uid, EmploymentModel employment) async {
    await _collection(uid)
        .doc(employment.id)
        .update(employment.toMap());
  }

  Future<void> deleteEmployment(
      String uid, String id) async {
    await _collection(uid).doc(id).delete();
  }

  Stream<List<EmploymentModel>> getEmployments(String uid) {
    return _collection(uid)
        .orderBy("startDate")
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) =>
        EmploymentModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList());
  }

}