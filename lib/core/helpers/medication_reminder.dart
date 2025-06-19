import 'package:healthstack/core/networking/notification_service.dart';
import 'package:healthstack/features/prescriptions/data/models/prescriptions_response_model.dart';

class MedicineReminderHelper {
  
  /// Schedule medicine reminders based on prescription data
  static Future<void> scheduleMedicineReminders({
    required PrescriptionsResponseModel prescriptions,
  }) async {
    if (prescriptions.prescriptionsMedicine == null) return;

    for (var prescription in prescriptions.prescriptionsMedicine!) {
      await _schedulePrescriptionReminders(prescription);
    }
  }

  /// Schedule reminders for a single prescription medicine
  static Future<void> _schedulePrescriptionReminders(
    PrescriptionMedicineModel prescription,
  ) async {
    // Parse medicine times from prescription
    List<DateTime> medicineTimes = _parseMedicineTimes(
      prescription.frequency,
      prescription.duration,
      null, // endDate is not available in PrescriptionMedicineModel, adjust if needed
    );

    for (DateTime scheduleTime in medicineTimes) {
      // Only schedule future reminders
      if (scheduleTime.isAfter(DateTime.now())) {
        await NotificationService.scheduleMedicineReminder(
          id: _generateReminderId(prescription.medicineId, scheduleTime),
          medicineName: prescription.medicineName ?? 'Medicine',
          dosage: prescription.quantity ?? 'As prescribed',
          scheduledTime: scheduleTime,
          additionalData: {
            'prescription_id': prescription.prescription,
            'medicine_id': prescription.medicineId,
            // Add more fields if needed
          },
        );
      }
    }
  }

  /// Parse medicine times from prescription data
  static List<DateTime> _parseMedicineTimes(
    String? medicineTime,
    String? startDate,
    String? endDate,
  ) {
    List<DateTime> scheduledTimes = [];

    if (medicineTime == null || startDate == null) return scheduledTimes;

    try {
      DateTime start = DateTime.parse(startDate);
      DateTime end = endDate != null 
          ? DateTime.parse(endDate) 
          : start.add(const Duration(days: 30)); // Default 30 days

      // Parse medicine times (assuming format like "08:00,14:00,20:00" or "Morning,Afternoon,Evening")
      List<String> times = medicineTime.split(',');
      
      for (String timeStr in times) {
        List<DateTime> dailyTimes = _parseTimeString(timeStr.trim(), start, end);
        scheduledTimes.addAll(dailyTimes);
      }
    } catch (e) {
      print('❌ Error parsing medicine times: $e');
    }

    return scheduledTimes;
  }

  /// Parse individual time string and generate daily reminders
  static List<DateTime> _parseTimeString(String timeStr, DateTime start, DateTime end) {
    List<DateTime> times = [];
    
    // Map common time descriptions to actual times
    Map<String, String> timeMap = {
      'morning': '08:00',
      'afternoon': '14:00',
      'evening': '20:00',
      'night': '22:00',
      'before breakfast': '07:30',
      'after breakfast': '09:00',
      'before lunch': '12:30',
      'after lunch': '14:30',
      'before dinner': '19:30',
      'after dinner': '21:00',
    };

    // Convert time description to actual time if needed
    String actualTime = timeMap[timeStr.toLowerCase()] ?? timeStr;

    // Parse time (expected format: "HH:MM")
    try {
      List<String> timeParts = actualTime.split(':');
      if (timeParts.length == 2) {
        int hour = int.parse(timeParts[0]);
        int minute = int.parse(timeParts[1]);

        // Generate daily reminders from start to end date
        DateTime currentDate = start;
        while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
          DateTime reminderTime = DateTime(
            currentDate.year,
            currentDate.month,
            currentDate.day,
            hour,
            minute,
          );

          // Only add future times
          if (reminderTime.isAfter(DateTime.now())) {
            times.add(reminderTime);
          }

          currentDate = currentDate.add(const Duration(days: 1));
        }
      }
    } catch (e) {
      print('❌ Error parsing time string "$timeStr": $e');
    }

    return times;
  }

  /// Generate unique reminder ID
  static int _generateReminderId(int? prescriptionId, DateTime scheduleTime) {
    return (prescriptionId ?? 0) * 1000000 + scheduleTime.millisecondsSinceEpoch ~/ 1000;
  }

  /// Cancel all medicine reminders for a prescription
  static Future<void> cancelPrescriptionReminders(int prescriptionId) async {
    try {
      await NotificationService.cancelAllNotifications();
      print('🗑️ Cancelled reminders for prescription $prescriptionId');
    } catch (e) {
      print('❌ Error cancelling prescription reminders: $e');
    }
  }

  /// Reschedule all active medicine reminders (useful after app restart)
  static Future<void> rescheduleAllMedicineReminders(
    PrescriptionsResponseModel prescriptions,
  ) async {
    await NotificationService.cancelAllNotifications();
    await scheduleMedicineReminders(prescriptions: prescriptions);
    print('🔄 Rescheduled all medicine reminders');
  }
}