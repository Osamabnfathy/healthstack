import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/widgets/search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import 'package:healthstack/features/doctors/ui/widgets/doctors_list_bloc_builder.dart';


class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() =>
    _DoctorPageState();
}

class _DoctorPageState extends State<DoctorsScreen> {
  late TextEditingController searchController;
  String searchQuery = '';
  bool isSorted = true;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = searchController.text.trim().toLowerCase();
    });
  }
  
  void _onFilterPressed() {
    setState(() {
      isSorted = !isSorted;
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
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(12.w, 5.h, 12.w, 15.h),
              
              child: Column(
                children: [
                  const CustomTopBar(title: 'Find Doctor'), 
                   
                  SearchAndFilterBar(
                    searchController: searchController,
                    onFilterPressed: _onFilterPressed,
                    hintText: "Search Doctors ....",
                  ),
                  verticalSpace(10),
                  
                  Expanded(
                    child: DoctorsListBlocBuilder(
                      searchQuery: searchQuery,
                      isSorted: isSorted,
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}