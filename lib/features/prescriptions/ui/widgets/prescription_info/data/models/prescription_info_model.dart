
class DoctorInfo {
  final String name;
  final String department;
  final String email;

  DoctorInfo({
    required this.name,
    required this.department,
    required this.email,
  });
}

class PatientInfo {
  final String name;
  final String address;
  final String email;
  final String phoneNumber;

  PatientInfo({
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
  });
}

class Medicine {
  final String name;
  final String quantity;
  final String frequency;
  final String duration;
  final String relationWithMeal;
  final String instruction;

  Medicine({
    required this.name,
    required this.quantity,
    required this.frequency,
    required this.duration,
    required this.relationWithMeal,
    required this.instruction,
  });
}

class MedicalTest {
  final String name;
  final String description;
  final bool isSelected;

  MedicalTest({
    required this.name,
    required this.description,
    this.isSelected = false,
  });
}

class PrescriptionData {
  final String prescriptionId;
  final String patientId;
  final DateTime date;
  final DoctorInfo doctor;
  final PatientInfo patient;
  final List<Medicine> medicines;
  final List<MedicalTest> tests;
  final String advice;

  PrescriptionData({
    required this.prescriptionId,
    required this.patientId,
    required this.date,
    required this.doctor,
    required this.patient,
    required this.medicines,
    required this.tests,
    required this.advice,
  });
}