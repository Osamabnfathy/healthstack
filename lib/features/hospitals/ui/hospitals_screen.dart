import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import 'package:healthstack/core/widgets/search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/hospitals/ui/widgets/hospitals_list_bloc_builder.dart';

class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({super.key});

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
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
      backgroundColor: ColorsManager.lightBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTopBar(title:'Find Hospital'),
              verticalSpace(20),
              SearchAndFilterBar(
                searchController: searchController,
                onFilterPressed: _onFilterPressed,
              ),
              verticalSpace(10),
              Expanded(
                child: HospitalsListBlocBuilder(
                  searchQuery: searchQuery,
                  isSorted: isSorted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}