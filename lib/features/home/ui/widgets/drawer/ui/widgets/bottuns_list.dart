import 'buttons_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/constants.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/shared_pref_helper.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';

class ButtonsList extends StatelessWidget {
  const ButtonsList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubitInstance = context.read<HomeCubit>();
    
    final menuItems = [
      MenuItemData(
        'Medical Records',
        Colors.green.shade50,
        Colors.green,
        () {/* navigation  */},
        icon: Icons.medical_information_outlined,
      ),
      
      MenuItemData(
        'Hospitals List',
        Colors.pink.shade50,
        Colors.pink,
        () => context.pushNamed(Routes.hospitalsScreen, arguments: homeCubitInstance),
        icon: Icons.local_hospital,
      ),
      
      MenuItemData(
        'Change Password',
        Colors.purple.shade50,
        Colors.purple,
        () => context.pushNamed(Routes.changePasswordScreen),
        icon: Icons.lock_outline,
      ),
      
      MenuItemData(
        'Personal Information',
        Colors.blue.shade50,
        Colors.blue,
        () => context.pushNamed(Routes.editProfileScreen , arguments: homeCubitInstance),
        image: Image.asset('assets/icons/personalcard.png', height: 22.h, width: 22.w),
      ),
      
      MenuItemData(
        'Sign Out',
      Colors.red.shade50,
      Colors.red,
      () async {
        await SharedPrefHelper.removeSecured(SharedPrefKeys.userToken);
        // ignore: use_build_context_synchronously
        context.pushNamedAndRemoveUntil(
          Routes.loginScreen, (route) => false,
          predicate: (Route<dynamic> route) => false,
        );
      },
        icon: Icons.exit_to_app,
      ),
      
      MenuItemData(
        'About Us',
        Colors.amber.shade50,
        Colors.amber.shade700,
        () {/*navigation */},
        icon: Icons.call,
      ),
    ];

    return Container(
      color: ColorsManager.lighterGray, 
      padding: EdgeInsets.symmetric(horizontal: 10.w).copyWith(top: 10.h), 
       
      child: ListView.separated(
        physics: const BouncingScrollPhysics(), 
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
