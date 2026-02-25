
class OptModel {
  final DateTime optStartDate;
  final DateTime optEndDate;
  final int unemploymentDaysUsed;
  final bool stemOptEligible;

  OptModel({
    required this.optStartDate,
    required this.optEndDate,
    required this.unemploymentDaysUsed,
    required this.stemOptEligible,
  });

  Map<String, dynamic> toJson() => {
    "optStartDate": optStartDate,
    "optEndDate": optEndDate,
    "unemploymentDaysUsed": unemploymentDaysUsed,
    "stemOptEligible": stemOptEligible,
  };

  factory OptModel.fromJson(Map<String, dynamic> json) => OptModel(
    optStartDate: (json["optStartDate"]).toDate(),
    optEndDate: (json["optEndDate"]).toDate(),
    unemploymentDaysUsed: json["unemploymentDaysUsed"],
    stemOptEligible: json["stemOptEligible"],
  );
}