import 'buttons_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';

class ButtonsList extends StatelessWidget {
  const ButtonsList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubitInstance = context.read<HomeCubit>();
    
    final menuItems = [
      MenuItemData(
        'Personal Information',
        Colors.blue.shade50,
        Colors.blue,
        () => context.pushNamed(Routes.profileScreen),
        image: Image.asset('assets/icons/personalcard.png', height: 22.h, width: 22.w),
      ),
      
      MenuItemData(
        'My Test & Diagnostic',
        Colors.green.shade50,
        Colors.green,
        () {/* navigation  */},
        icon: Icons.science_outlined,
      ),
      
      MenuItemData(
        'Hospitals',
        Colors.pink.shade50,
        Colors.pink,
        () => context.pushNamed(Routes.hospitalsScreen, arguments: homeCubitInstance),
        icon: Icons.local_hospital,
      ),
      
      MenuItemData(
        'About Us',
        Colors.amber.shade50,
        Colors.amber.shade700,
        () {/*navigation */},
        icon: Icons.info_outline,
      ),
      
      MenuItemData(
        'Contact Us',
        Colors.purple.shade50,
        Colors.purple,
        () {/* navigation*/},
        icon: Icons.phone_outlined,
      ),
      
      MenuItemData(
        'Sign Out',
        Colors.red.shade50,
        Colors.red,
        () => context.pushNamedAndRemoveUntil(Routes.loginScreen, predicate: (Route<dynamic> route) { return false; }),
        icon: Icons.exit_to_app,
      ),
    ];

    return Container(
      color: ColorsManager.lighterGray, 
      padding: EdgeInsets.symmetric(horizontal: 10.w).copyWith(top: 10.h), // List horizental padding
       
      child: ListView.separated(
        physics: const BouncingScrollPhysics(), // Good for lists that might not scroll much
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return MenuItemWidget(item: item);
        },
      ),
    );
  }
}
