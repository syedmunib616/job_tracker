import 'package:cloud_firestore/cloud_firestore.dart';

class EmploymentModel {
  final String id;
  final String companyName;
  final DateTime startDate;
  final DateTime? endDate; // null = currently working

  EmploymentModel({
    required this.id,
    required this.companyName,
    required this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      "companyName": companyName,
      "startDate": startDate,
      "endDate": endDate,
    };
  }

  factory EmploymentModel.fromMap(String id, Map<String, dynamic> map) {
    return EmploymentModel(
      id: id,
      companyName: map["companyName"],
      startDate: (map["startDate"] as Timestamp).toDate(),
      endDate: map["endDate"] != null
          ? (map["endDate"] as Timestamp).toDate()
          : null,
    );
  }
}