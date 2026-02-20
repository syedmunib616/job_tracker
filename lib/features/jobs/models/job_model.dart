class JobModel {
  final String company;
  final String status;

  JobModel({required this.company, required this.status});

  Map<String,dynamic> toMap(){
    return {"company":company, "status":status};
  }

}