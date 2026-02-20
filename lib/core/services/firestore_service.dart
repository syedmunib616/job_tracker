import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _db=FirebaseFirestore.instance;

  Future addJob(Map<String, dynamic> data)async{
    await _db.collection('jobs').add(data);
  }

}