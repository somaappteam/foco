import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    
    tz_data.initializeTimeZones();

    const AndroidInitializationSettings androidSettings = 
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        // Handle tap - deep link to decay alert
      },
    );

    _initialized = true;
  }

  // Critical: Alert when words are about to fade
  Future<void> scheduleDecayWarning(String wordId, String wordText, DateTime fadeDate) async {
    final scheduledDate = fadeDate.subtract(const Duration(hours: 12)); // 12h warning
    
    if (scheduledDate.isBefore(DateTime.now())) return;

    await _notifications.zonedSchedule(
      wordId.hashCode,
      'Memory Fading',
      '"$wordText" will be lost to darkness in 12 hours',
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'foco_decay',
          'Word Decay Alerts',
          channelDescription: 'Warnings before words are permanently lost',
          importance: Importance.high,
          priority: Priority.high,
          color: Color(0xFFFF453A), // batteryCritical red
          ledColor: Color(0xFFFF453A),
          ledOnMs: 1000,
          ledOffMs: 500,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.timeSensitive,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: 
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'decay_alert:$wordId',
    );
  }

  // Battery depleted reminder
  Future<void> showBatteryDeadReminder() async {
    await _notifications.show(
      999,
      'Flashlight Depleted',
      'Your discoveries are waiting in the dark. Recharge to continue.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'foco_battery',
          'Battery Alerts',
          importance: Importance.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  // Cancel all notifications for a word (if rescued)
  Future<void> cancelDecayWarning(String wordId) async {
    await _notifications.cancel(wordId.hashCode);
  }

  // Daily reminder (optional, only if streak at risk)
  Future<void> scheduleDailyReminder(DateTime time) async {
    await _notifications.zonedSchedule(
      888,
      'The Darkness Awaits',
      'Your daily expedition is ready. New secrets hide in the shadows.',
      tz.TZDateTime.from(time, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'foco_daily',
          'Daily Reminders',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: 
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
