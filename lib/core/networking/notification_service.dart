import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/my_appointment/data/models/my_appointments_response_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin = 
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Initialize timezones
    tz.initializeTimeZones();
    
    // For production, use device timezone instead of hardcoding
    try {
      final location = tz.getLocation('Africa/Cairo');
      tz.setLocalLocation(location);
    } catch (e) {
      tz.setLocalLocation(tz.UTC);
    }

    // Android-specific initialization
    const AndroidInitializationSettings androidInit = 
        AndroidInitializationSettings('@mipmap/launcher_icon');
    
    const InitializationSettings settings = 
        InitializationSettings(android: androidInit);

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
      }
    );
    
    // Create notification channel for Android 8.0+
    await _createNotificationChannel();
  }

  static Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'appointment_channel',
      'Appointment Notifications',
      description: 'Notifications for upcoming appointments',
      importance: Importance.max,
      playSound: true,
    );
    
    await _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    try {
      // Create Android-specific details
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'appointment_channel', 
        'Appointment Notifications',
        channelDescription: 'Notifications for upcoming appointments',
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
      );

      // Convert to timezone-aware datetime
      final tz.TZDateTime tzScheduledTime = 
          tz.TZDateTime.from(scheduledTime, tz.local);

      await _plugin.zonedSchedule(
        id,
        title,
        body,
        tzScheduledTime,
        NotificationDetails(android: androidDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: 
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      print('❌ Error scheduling notification: $e');
    }
  }

  static Future<void> showImmediateTestNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'appointment_channel',
      'Appointment Notifications',
      channelDescription: 'Notifications for upcoming appointments',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _plugin.show(
      999,
      'MediCare Test',
      'Notification service is working! ${DateTime.now().toLocal()}',
      NotificationDetails(android: androidDetails),
    );
  }
  
  // Add cancel method for debugging
  static Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }
  
  static Future<void> scheduleAppointmentNotification({
    required MyAppointmentResponseModel appointment,
    required DoctorsResponseModel? doctor,
  }) async {
    try {
      final scheduledTime = _calculateNotificationTime(
        appointment.date, 
        appointment.time
      );

      await scheduleNotification(
        id: appointment.id ?? appointment.hashCode,
        title: 'Upcoming Appointment',
        body: 'With Dr. ${doctor?.name} at ${_formatTime(scheduledTime.add(Duration(minutes: 60)))}',
        scheduledTime: scheduledTime,
      );
    } catch (e) {
      debugPrint('❌ Notification scheduling error: $e');
    }
  }

  static DateTime _calculateNotificationTime(String? date, String? time) {
    final aptDateTime = _parseDateTime(date, time);
    return aptDateTime.subtract(const Duration(minutes: 60));
  }

  static String _formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${dt.minute.toString().padLeft(2, '0')} $period';
  }

  // UPDATED: ROBUST DATE PARSING
  static DateTime _parseDateTime(String? date, String? time) {
    try {
      if (date == null || time == null) throw 'Missing date/time';
      
      final dateParts = date.split('-');
      final timeParts = time.split(':');
      
      return DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
    } catch (e) {
      return DateTime.now().add(Duration(days: 1)); 
    }
  }
}
