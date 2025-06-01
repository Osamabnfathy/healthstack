import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/widgets/search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/widgets/custom_app_bar.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(12.w, 5.h, 12.w, 15.h),
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [ 
                  const CustomAppBar(title: 'Find Hospitals'),   
                                
                  SearchAndFilterBar(
                    searchController: searchController, 
                    onFilterPressed: _onFilterPressed,
                  ),
                  verticalSpace(10),
                  
                  Expanded(child: HospitalsListBlocBuilder(
                    searchQuery: searchQuery,
                    isSorted: isSorted,
                  )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}