import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_tracker/features/opt/opt_model/opt_model.dart';

class OptService {
  final _db = FirebaseFirestore.instance;

  // Add / Update OPT
  Future<void> saveOpt(String uid, OptModel opt) async {
    await _db
        .collection("users")
        .doc(uid)
        .collection("optTimeline")
        .doc("main")
        .set(opt.toJson()); // set = add + update
  }

  // Get OPT Stream
  Stream<OptModel?> streamOpt(String uid) {
    return _db
        .collection("users")
        .doc(uid)
        .collection("optTimeline")
        .doc("main")
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;
      return OptModel.fromJson(doc.data()!);
    });
  }
}