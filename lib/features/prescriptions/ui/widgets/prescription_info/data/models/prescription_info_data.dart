import 'package:healthstack/features/prescriptions/ui/widgets/prescription_info/data/models/prescription_info_model.dart';

PrescriptionData getSamplePrescriptionData() {
    return PrescriptionData(
      prescriptionId: '36',
      patientId: '7',
      date: DateTime(2025, 5, 8),
      doctor: DoctorInfo(
        name: 'Ahmed Khalid',
        department: 'Dentistry - United Hospital',
        email: 'medicaresvn@gmail.com',
      ),
      patient: PatientInfo(
        name: 'Ahmed Ali',
        address: 'testt',
        email: 'bdalshwrjmal638@gmail.com',
        phoneNumber: '36',
      ),
      medicines: [
        Medicine(
          name: 'Paracetamol 500mg',
          quantity: '2 tablets',
          frequency: '3 times a day',
          duration: '5 days',
          relationWithMeal: 'After meals',
          instruction: 'Drink plenty of water. Avoid alcohol.',
        ),
         Medicine(
          name: 'Amoxicillin 250mg',
          quantity: '1 cap',
          frequency: 'BD (2/day)',
          duration: '7 days',
          relationWithMeal: 'With food',
          instruction: 'Complete the full course as prescribed by the doctor.',
        ),
      ],
      tests: [
        MedicalTest(
          name: 'CBC',
          description: 'Fasting blood sugar level check',
        ),
        MedicalTest(
          name: 'Lipid Profile',
          description: 'Measures cholesterol and triglyceride levels.',
          isSelected: true,
        ),
      ],
      advice: 'Consult your doctor if fever persists beyond 3 days. Maintain adequate hydration and rest.',
    );
  }