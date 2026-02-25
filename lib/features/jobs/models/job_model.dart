import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  final String id;
  final String company;
  final String role;
  final String location;
  final String status;
  final double salary;
  final String notes;
  final DateTime createdAt;

  JobModel({
    required this.id,
    required this.company,
    required this.role,
    required this.location,
    required this.status,
    required this.salary,
    required this.notes,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "company": company,
      "role": role,
      "location": location,
      "status": status,
      "salary": salary,
      "notes": notes,
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }

  factory JobModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return JobModel(
      id: doc.id,
      company: data["company"] ?? "",
      role: data["role"] ?? "",
      location: data["location"] ?? "",
      status: data["status"] ?? "Applied",
      salary: (data["salary"] ?? 0).toDouble(),
      notes: data["notes"] ?? "",
      createdAt: (data["createdAt"] as Timestamp).toDate(),
    );
  }
}