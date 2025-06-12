// lib/features/doctor_speciality/ui/widgets/speciality_grid_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/medical_departments/ui/widgets/medical_departments_item.dart';

class MedicalDepartmentsGridView extends StatelessWidget {
  const MedicalDepartmentsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final specialities = [
      {'name': 'General', 'icon': 'assets/icons/Man_Doctor_Europe.png'},
      {'name': 'ENT', 'icon': 'assets/icons/Ent.png'},
      {'name': 'Pediatric', 'icon': 'assets/icons/Baby.png'},
      {'name': 'Urologist', 'icon': 'assets/icons/Kidneys.png'},
      {'name': 'Dentistry', 'icon': 'assets/icons/Dent.png'},
      {'name': 'Intestine', 'icon': 'assets/icons/Intestine.png'},
      {'name': 'Histologist', 'icon': 'assets/icons/Histology.png'},
      {'name': 'Hepatology', 'icon': 'assets/icons/Hepatology.png'},
      {'name': 'Cardiologist', 'icon': 'assets/icons/Heart.png'},
      {'name': 'Neurologic', 'icon': 'assets/icons/Brain.png'},
      {'name': 'Pulmonary', 'icon': 'assets/icons/Pulmonary.png'},
      {'name': 'Optometry', 'icon': 'assets/icons/Eye.png'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 24.h,
        childAspectRatio: 0.85,
      ),
      itemCount: specialities.length,
      itemBuilder: (context, index) {
        final speciality = specialities[index];
        return MedicalDepartmentsItem(
          iconAsset: speciality['icon']!,
          name: speciality['name']!,
          onTap: () {
            print('Tapped on ${speciality['name']}');
            // Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorsListPage(speciality: speciality['name']!)));
          },
        );
      },
    );
  }
}
