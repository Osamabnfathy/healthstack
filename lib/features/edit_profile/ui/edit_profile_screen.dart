import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/edit_profile/ui/widgets/profile_forms.dart';
import 'package:healthstack/features/edit_profile/ui/widgets/profile_image.dart';
import 'package:healthstack/features/edit_profile/ui/widgets/profile_top_bar.dart';
import 'package:healthstack/features/edit_profile/ui/widgets/save_changes_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _newProfileImage;

  void _onImagePicked(File? file) {
    setState(() {
      _newProfileImage = file;
    });
  }

  // void _onSavePressed() {
  //   context.read<HomeCubit>().updateProfile(
      
  //     imageFile: _newProfileImage,
  //   );
  // }
  
  @override
  Widget build(BuildContext context) {
    final profileData = context.watch<HomeCubit>().patientProfileData;
    
    return Scaffold(
        backgroundColor: ColorsManager.lightBlue,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ProfileTopBar(),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  child: Column(
                    children: [
                      ProfileImage(data: profileData, onImagePicked: _onImagePicked,),
                      verticalSpace(20),
                      
                      ProfileForms(data: profileData),
                      verticalSpace(30),
                      
                      const SaveChangesButton(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
