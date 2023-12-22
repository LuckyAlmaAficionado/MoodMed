import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationController extends GetxController {
  static FlutterLocalNotificationsPlugin flnp =
      FlutterLocalNotificationsPlugin();

  static Future initializePermissionHandler() async {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  static Future initializeNotificationC() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    // initial plugin
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flnp.initialize(initializationSettings);
  }

  Future<void> cancellingAllNotifications() async {
    await flnp.cancelAll();
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required TimeOfDay reminder,
  }) async {
    debugPrint('on clicked');
    var now = tz.TZDateTime.now(tz.local);
    var scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      reminder.hour,
      reminder.minute,
    );

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    var androidPlatformChannelSpecifies =
        const AndroidNotificationDetails('reminder', 'reminder_medicine');

    var platformChannelSpecifies = NotificationDetails(
      android: androidPlatformChannelSpecifies,
    );

    await flnp.zonedSchedule(
      DateTime.now().microsecond,
      title,
      body,
      scheduleDate,
      platformChannelSpecifies,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
