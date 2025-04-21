import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/doctors/data/doctors_data.dart';
import 'package:healthstack/features/doctors/ui/widgets/search_bar.dart';
import 'package:healthstack/features/doctors/ui/widgets/doctor_list_view.dart';


class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() =>
    _DoctorPageState();
}

class _DoctorPageState extends State<DoctorsScreen> {
  late TextEditingController searchController;
  late List<Map<String, dynamic>> filteredDoctors;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredDoctors = doctors;
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredDoctors = doctors.where((doctor) {
        return doctor['name'].toLowerCase().contains(query) ||
            doctor['specialty'].toLowerCase().contains(query) ||
            doctor['hospital'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.moreLightGray,
      
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Find Doctor', 
          style: TextStyles.font20DarkBlueSemiBold,
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context), // Close drawer action
          child: Icon(Icons.arrow_back_ios_new_outlined, color: ColorsManager.darkBlue, size: 20.sp,),
        ),
      ),
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SearchAndFilterBar(
                searchController: searchController,
                onFilterPressed: () {
                  // Handle filter button press
                },
              ),
              verticalSpace(20),
              
              DoctorsListView(doctors: filteredDoctors),
            ],
          ),
        ),
      ),
    );
  }
}