

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:job_tracker/core/services/notification_service.dart';
import 'package:job_tracker/core/services/opt_service.dart';
import 'package:job_tracker/features/auth/view_models/auth_view_model.dart';
import 'package:job_tracker/features/opt/opt_model/opt_model.dart';







final optServiceProvider = Provider((ref) => OptService());
final notificationServiceProvider = Provider((ref) => NotificationService());
final optProvider = StreamProvider<OptModel?>((ref) {
  final uid = ref.read(authServiceProvider).currentUser!.uid;
  return ref.read(optServiceProvider).streamOpt(uid);
});

class OptViewModel extends StateNotifier<bool> {
  final OptService _service;
  final NotificationService _notificationService;
  final String uid;

  OptViewModel(this._service, this.uid, this._notificationService) : super(false);

  Future<void> saveOpt(OptModel opt) async {
    state = true;
    await _service.saveOpt(uid, opt);

    //  Cancel old reminders
    await _notificationService.cancelAllScheduled();

    //  Schedule new reminders
    await _notificationService.scheduleOptReminders(opt.optStartDate);
    //await _notificationService.scheduleOptReminders(DateTime.now());

    state = false;
  }


}

final optViewModelProvider =
StateNotifierProvider<OptViewModel, bool>((ref) {
  final uid = ref.read(authServiceProvider).currentUser!.uid;

  return OptViewModel(
    ref.read(optServiceProvider),
    uid,
    ref.read(notificationServiceProvider),

  );
});

//
// final optViewModelProvider =
// StateNotifierProvider<OptViewModel, bool>((ref) {
//   final uid = ref.read(authServiceProvider).currentUser!.uid;
//   return OptViewModel(ref.read(optServiceProvider), uid);
// });