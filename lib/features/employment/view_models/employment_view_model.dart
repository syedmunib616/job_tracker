import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:job_tracker/core/services/employment_service.dart';
import 'package:job_tracker/features/auth/view_models/auth_view_model.dart';
import 'package:job_tracker/features/employment/models/employment_model.dart';

final employmentServiceProvider =
Provider((ref) => EmploymentService());

final employmentStreamProvider =
StreamProvider<List<EmploymentModel>>((ref) {
  final service = ref.watch(employmentServiceProvider);
  final uid = ref.read(authServiceProvider).currentUser!.uid;

  return service.getEmployments(uid);
});

final employmentViewModelProvider =
StateNotifierProvider<EmploymentViewModel, bool>((ref) {
  final service = ref.watch(employmentServiceProvider);
  final uid = ref.read(authServiceProvider).currentUser!.uid;
  return EmploymentViewModel(service, uid);
});

class EmploymentViewModel extends StateNotifier<bool> {
  final EmploymentService _service;
  final String uid;

  EmploymentViewModel(this._service, this.uid)
      : super(false);

  Future<void> addEmployment(EmploymentModel employment) async {
    state = true;
    await _service.addEmployment(uid, employment);
    state = false;
  }

  Future<void> updateEmployment(EmploymentModel employment) async {
    state = true;
    await _service.updateEmployment(uid, employment);
    state = false;
  }

  Future<void> deleteEmployment(String id) async {
    await _service.deleteEmployment(uid, id);
  }

}