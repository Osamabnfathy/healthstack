import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:healthstack/core/helpers/shared_pref_helper.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/my_appointment/data/models/my_appointments_response_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// Define a global navigatorKey for navigation from notification handlers
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Top-level function for background message handling
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔥 Background message received: ${message.messageId}");
  
  // Handle background message logic here
  await NotificationService._handleBackgroundMessage(message);
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin = 
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  // Notification channel IDs
  static const String _appointmentChannelId = 'appointment_channel';
  static const String _medicineChannelId = 'medicine_channel';
  static const String _generalChannelId = 'general_channel';

  static Future<void> init() async {
    await _initializeFirebase();
    await _initializeLocalNotifications();
    await _setupFCM();
    await _createNotificationChannels();
  }

  // ========== FIREBASE INITIALIZATION ==========
  static Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    
    // Set the background messaging handler early on
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  // ========== LOCAL NOTIFICATIONS SETUP ==========
  static Future<void> _initializeLocalNotifications() async {
    // Initialize timezones
    tz.initializeTimeZones();
    
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

    await _localNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _handleNotificationTap,
    );
  }

  // ========== FCM SETUP ==========
  static Future<void> _setupFCM() async {
    // Request permission for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('🔔 FCM Permission status: ${settings.authorizationStatus}');

    // Get FCM token and save it
    await _getFCMTokenAndSave();

    // Listen to token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen(_saveTokenToPreferences);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle message when app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
  }

 // ========== FCM TOKEN MANAGEMENT ==========
static Future<void> _getFCMTokenAndSave() async {
  try {
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      await _saveTokenToPreferences(token);
      print('🔑 FCM Token: $token');
      await _sendTokenToBackend(token);
    }
  } catch (e) {
    print('❌ Error getting FCM token: $e');
  }
}

static Future<void> _saveTokenToPreferences(String token) async {
  await SharedPrefHelper.setSecuredString('fcm_token', token);
}

static Future<String?> getFCMToken() async {
  return await SharedPrefHelper.getSecuredString('fcm_token');
}

// ========== SEND TOKEN TO BACKEND ==========
static Future<void> _sendTokenToBackend(String token) async {
  try {
    // TODO: Replace with your actual API call
    // Example: await getIt<ApiService>().updateFCMToken({'fcm_token': token});
    print('📤 Token should be sent to backend: $token');
    // For now, just save locally. Implement API call based on your backend needs.
  } catch (e) {
    print('❌ Error sending token to backend: $e');
  }
}

  // ========== MESSAGE HANDLERS ==========
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    print('📱 Foreground message received: ${message.notification?.title}');
    
    // Show local notification when app is in foreground
    await _showNotificationFromFCM(message);
  }

  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print('🔙 Background message received: ${message.notification?.title}');
    
    // Handle background message logic
    // You can update local data, schedule notifications, etc.
  }

  static Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    print('🚀 App opened from notification: ${message.notification?.title}');
    
    // Handle navigation based on notification data
    await _handleNotificationNavigation(message.data);
  }

  static Future<void> _handleNotificationTap(NotificationResponse response) async {
    print('👆 Local notification tapped: ${response.payload}');
    
    if (response.payload != null) {
      Map<String, dynamic> data = jsonDecode(response.payload!);
      await _handleNotificationNavigation(data);
    }
  }

  // ========== NOTIFICATION CHANNELS ==========
  static Future<void> _createNotificationChannels() async {
    final androidPlugin = _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      // Appointment notifications channel
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          _appointmentChannelId,
          'Appointment Notifications',
          description: 'Notifications for appointment updates',
          importance: Importance.high,
          playSound: true,
        ),
      );

      // Medicine reminder channel
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          _medicineChannelId,
          'Medicine Reminders',
          description: 'Notifications for medicine reminders',
          importance: Importance.high,
          playSound: true,
        ),
      );

      // General notifications channel
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          _generalChannelId,
          'General Notifications',
          description: 'General app notifications',
          importance: Importance.high,
          playSound: true,
        ),
      );
    }
  }

  // ========== SHOW NOTIFICATIONS ==========
  static Future<void> _showNotificationFromFCM(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      _generalChannelId,
      'General Notifications',
      channelDescription: 'General app notifications',
      importance: Importance.high,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
    );

    await _localNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(android: androidDetails),
      payload: jsonEncode(message.data),
    );
  }

  // ========== APPOINTMENT NOTIFICATIONS ==========
  static Future<void> showAppointmentAcceptedNotification({
    required String doctorName,
    required String appointmentDate,
    required String appointmentTime,
    Map<String, dynamic>? additionalData,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      _appointmentChannelId,
      'Appointment Notifications',
      channelDescription: 'Notifications for appointment updates',
      importance: Importance.high,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
      icon: '@mipmap/launcher_icon',
    );

    Map<String, dynamic> payload = {
      'type': 'appointment_accepted',
      'doctor_name': doctorName,
      'date': appointmentDate,
      'time': appointmentTime,
      ...?additionalData,
    };

    await _localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      '✅ Appointment Confirmed',
      'Dr. $doctorName has accepted your appointment for $appointmentDate at $appointmentTime',
      const NotificationDetails(android: androidDetails),
      payload: jsonEncode(payload),
    );
  }

  static Future<void> showAppointmentCancelledNotification({
    required String doctorName,
    required String appointmentDate,
    required String appointmentTime,
    String? reason,
    Map<String, dynamic>? additionalData,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      _appointmentChannelId,
      'Appointment Notifications',
      channelDescription: 'Notifications for appointment updates',
      importance: Importance.high,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
      icon: '@mipmap/launcher_icon',
    );

    String body = 'Dr. $doctorName has cancelled your appointment for $appointmentDate at $appointmentTime';
    if (reason != null) {
      body += '\nReason: $reason';
    }

    Map<String, dynamic> payload = {
      'type': 'appointment_cancelled',
      'doctor_name': doctorName,
      'date': appointmentDate,
      'time': appointmentTime,
      'reason': reason,
      ...?additionalData,
    };

    await _localNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      '❌ Appointment Cancelled',
      body,
      const NotificationDetails(android: androidDetails),
      payload: jsonEncode(payload),
    );
  }

  // ========== MEDICINE REMINDER NOTIFICATIONS ==========
  static Future<void> scheduleMedicineReminder({
    required int id,
    required String medicineName,
    required String dosage,
    required DateTime scheduledTime,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        _medicineChannelId,
        'Medicine Reminders',
        channelDescription: 'Notifications for medicine reminders',
        importance: Importance.high,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
        icon: '@mipmap/launcher_icon',
      );

      final tz.TZDateTime tzScheduledTime = 
          tz.TZDateTime.from(scheduledTime, tz.local);

      Map<String, dynamic> payload = {
        'type': 'medicine_reminder',
        'medicine_name': medicineName,
        'dosage': dosage,
        'scheduled_time': scheduledTime.toIso8601String(),
        ...?additionalData,
      };

      await _localNotificationsPlugin.zonedSchedule(
        id,
        '💊 Medicine Reminder',
        'Time to take $medicineName ($dosage)',
        tzScheduledTime,
        const NotificationDetails(android: androidDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: jsonEncode(payload),
      );

      print('💊 Medicine reminder scheduled for $medicineName at $scheduledTime');
    } catch (e) {
      print('❌ Error scheduling medicine reminder: $e');
    }
  }

  // ========== EXISTING METHODS FROM YOUR ORIGINAL CODE ==========
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    try {
      // Create Android-specific details
      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        _appointmentChannelId, 
        'Appointment Notifications',
        channelDescription: 'Notifications for upcoming appointments',
        importance: Importance.high,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
      );

      // Convert to timezone-aware datetime
      final tz.TZDateTime tzScheduledTime = 
          tz.TZDateTime.from(scheduledTime, tz.local);

      await _localNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tzScheduledTime,
        const NotificationDetails(android: androidDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      print('❌ Error scheduling notification: $e');
    }
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

      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        _appointmentChannelId,
        'Appointment Notifications',
        channelDescription: 'Notifications for upcoming appointments',
        importance: Importance.high,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
      );

      final tz.TZDateTime tzScheduledTime = 
          tz.TZDateTime.from(scheduledTime, tz.local);

      Map<String, dynamic> payload = {
        'type': 'appointment_reminder',
        'appointment_id': appointment.id,
        'doctor_name': doctor?.name,
        'date': appointment.date,
        'time': appointment.time,
      };

      await _localNotificationsPlugin.zonedSchedule(
        appointment.id ?? appointment.hashCode,
        'Upcoming Appointment',
        'With Dr. ${doctor?.name} at ${_formatTime(scheduledTime.add(const Duration(minutes: 60)))}',
        tzScheduledTime,
        NotificationDetails(android: androidDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: jsonEncode(payload),
      );
    } catch (e) {
      debugPrint('❌ Notification scheduling error: $e');
    }
  }

  // ========== NAVIGATION HANDLER ==========
static Future<void> _handleNotificationNavigation(Map<String, dynamic> data) async {
  String type = data['type'] ?? '';

  switch (type) {
    case 'appointment_accepted':
    case 'appointment_cancelled':
    case 'appointment_reminder':
      // TODO: Replace with your actual navigation logic
      // Example using a global navigatorKey:
       navigatorKey.currentState?.pushNamed('/appointmentScreen');
      print('🧭 Navigate to appointments screen');
      break;
    case 'medicine_reminder':
      // TODO: Replace with your actual navigation logic
      // Example using a global navigatorKey:
      navigatorKey.currentState?.pushNamed('/prescriptionInfoScreen');
      print('🧭 Navigate to medicine screen');
      break;
    default:
      print('🧭 Unknown notification type: $type');
  }
}

  // ========== UTILITY METHODS ==========
  static DateTime _calculateNotificationTime(String? date, String? time) {
    final aptDateTime = _parseDateTime(date, time);
    return aptDateTime.subtract(const Duration(minutes: 60));
  }

  static String _formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${dt.minute.toString().padLeft(2, '0')} $period';
  }

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
      return DateTime.now().add(const Duration(days: 1)); 
    }
  }

  // ========== TEST & DEBUG METHODS ==========
  static Future<void> showImmediateTestNotification() async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      _generalChannelId,
      'General Notifications',
      channelDescription: 'General app notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    await _localNotificationsPlugin.show(
      999,
      'MediCare Test',
      'FCM Notification service is working! ${DateTime.now().toLocal()}',
      const NotificationDetails(android: androidDetails),
    );
  }
  
  static Future<void> cancelAllNotifications() async {
    await _localNotificationsPlugin.cancelAll();
  }

  static Future<void> cancelNotification(int id) async {
    await _localNotificationsPlugin.cancel(id);
  }
}


/*
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
        const NotificationDetails(android: androidDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        // Removed the deprecated parameter
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
      const NotificationDetails(android: androidDetails),
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
        body: 'With Dr. ${doctor?.name} at ${_formatTime(scheduledTime.add(const Duration(minutes: 60)))}',
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
      return DateTime.now().add(const Duration(days: 1)); 
    }
  }
}
*/