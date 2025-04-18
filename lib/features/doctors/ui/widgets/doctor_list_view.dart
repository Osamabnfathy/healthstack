import 'package:flutter/material.dart';
import 'package:healthstack/features/doctors/ui/widgets/doctor_card.dart';


class DoctorsListView extends StatelessWidget {
  final List<Map<String, dynamic>> doctors;

  const DoctorsListView({
    super.key,
    required this.doctors,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return DoctorCard(
            name: doctor['name'],
            specialty: doctor['specialty'],
            hospital: doctor['hospital'],
            rating: doctor['rating'],
            reviews: doctor['reviews'],
            imageUrl: doctor['imageUrl'],
          );
        },
      ),
    );
  }
}