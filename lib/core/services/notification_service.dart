import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // tz.setLocalLocation(tz.getLocation('UTC'));
    tz.initializeTimeZones();

    final timezone = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(
      tz.getLocation(timezone.identifier),
    );

    print("Device timezone: ${timezone.identifier}");
    // tz.initializeTimeZones();
    // tz.setLocalLocation(tz.local);



    await Permission.notification.request();
    await Permission.scheduleExactAlarm.request();

    // final String timeZoneName =
    // await FlutterNativeTimezone.getLocalTimezone();
    //
    // tz.setLocalLocation(tz.getLocation(timeZoneName));

    // print("Device timezone: $timeZoneName");

    var status = await Permission.scheduleExactAlarm.status;
    if (!status.isGranted) {
      status = await Permission.scheduleExactAlarm.request();
      print(":::::::::granted");
      if (!status.isGranted) {
        print("Exact alarm permission denied → fallback to inexact");
        // You can fallback or show dialog asking user to grant in settings
      }
    }
    // 🔹 Initialize Local Notifications
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(android: androidInit);

    await _localNotifications.initialize(initSettings);

    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        // 'opt_channel',                      // must match what you use in zonedSchedule
        'opt_channel',
        'OPT Reminders',
        description: 'Notifications for OPT expiration reminders',
        importance: Importance.max,
        playSound: true,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    // 🔹 FCM Permission
    await _messaging.requestPermission();

    final token = await _messaging.getToken();
    print("token========= $token");
    await _saveTokenToFirestore(token);



    FirebaseMessaging.onMessage.listen((message) {
      _showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _showLocalNotification(message);
    });

  }



  Future<void> testSchedule() async {
    await _localNotifications.cancelAll();

    final now = tz.TZDateTime.now(tz.local);
    final scheduled = now.add(const Duration(seconds: 15));

    print("NOW: $now");
    print("SCHEDULED: $scheduled");

    await _localNotifications.zonedSchedule(
      1,
      'Zoned Test',
      'This should fire in 15 seconds',
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'opt_channel',
          'OPT Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );

    final pending =
    await _localNotifications.pendingNotificationRequests();
    print("Pending: ${pending.length}");
  }


  Future<void> scheduleOptReminders(DateTime startDate) async {
    final endDate = startDate.add(const Duration(days: 365));

    await _localNotifications.cancelAll();

    final reminderDays = [30, 15, 7, 1];

    for (int i = 0; i < reminderDays.length; i++) {
       final reminderDate =
      endDate.subtract(Duration(days: reminderDays[i]));

      if (reminderDate.isAfter(DateTime.now())) {

        await _localNotifications.zonedSchedule(
          i,
          'OPT Reminder',
          '${reminderDays[i]} days left before your OPT expires.',
          tz.TZDateTime.from(reminderDate, tz.local),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'opt_channel',
              'OPT Reminders',
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          // androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
        );

        print("Scheduled for $reminderDate");
      } else {
        print("Skipped past date: $reminderDate");
      }
    }

    final pending = await _localNotifications.pendingNotificationRequests();

    print("Pending notifications: ${pending.length}");

  }



  Future<void> cancelAllScheduled() async {
    await _localNotifications.cancelAll();
    final before =
    await _localNotifications.pendingNotificationRequests();
    print("Before scheduling: ${before.length}");
  }

  Future<void> _saveTokenToFirestore(String? token) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && token != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({"fcmToken": token});
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {

    const androidDetails = AndroidNotificationDetails(
      'opt_channel', // MUST MATCH
      'OPT Reminders',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );
    const details = NotificationDetails(android: androidDetails);
    await _localNotifications.show(
      0,
      message.notification?.title,
      message.notification?.body,
      details,
    );
  }

}

