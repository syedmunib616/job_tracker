

import 'package:job_tracker/core/services/firestore_service.dart';
import 'package:job_tracker/features/jobs/models/job_model.dart';

class JobViewModel {

  final FirestoreService _firestore= FirestoreService();

  addJob(JobModel job){
    return _firestore.addJob(job.toMap());
  }

}