import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _db.collection("users").doc(uid).set({
      "name": name,
      "email": email,
      "createdAt": FieldValue.serverTimestamp(),
    });

    // Default OPT document
    await _db.collection("users").doc(uid)
        .collection("optTimeline").doc("main")
        .set({
      "optStartDate": null,
      "unemploymentDaysUsed": 0,
      "stemOptEligible": false,
    });
  }
}