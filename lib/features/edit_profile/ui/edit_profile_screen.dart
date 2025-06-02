import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/di/dependency_injection.dart';
import 'package:healthstack/features/home/logic/cubit/home_cubit.dart';
import 'package:healthstack/features/edit_profile/ui/widgets/profile_forms.dart';
import 'package:healthstack/features/edit_profile/ui/widgets/profile_image.dart';
import 'package:healthstack/features/edit_profile/ui/widgets/profile_top_bar.dart';
import 'package:healthstack/features/edit_profile/ui/widgets/custom_snack_bar.dart';
import 'package:healthstack/features/edit_profile/ui/widgets/save_changes_button.dart';
import 'package:healthstack/features/edit_profile/logic/cubit/edit_profile_data_state.dart';
import 'package:healthstack/features/edit_profile/logic/cubit/edit_profile_data_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileData = context.watch<HomeCubit>().patientProfileData;

    return BlocProvider(
      create: (_) {
        final cubit = getIt<EditProfileDataCubit>();
        cubit.initWithProfile(profileData); 
        return cubit;
      },
      child: const _EditProfileScreenBody(),
    );
  }
}

class _EditProfileScreenBody extends StatelessWidget {
  const _EditProfileScreenBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileDataCubit>();
    
    return BlocListener<EditProfileDataCubit, EditProfileDataState>(
      listener: (context, state) {
        if (state is Success) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.success(message: "Your Profile data has been updated successfully! \nReload the app to see the changes."),
          );
        
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.homeScreen,
            (route) => false,
          );
        } 
        else if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.error(message: state.error),
          );
        }
      },
      
      child: Scaffold(
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
                        ProfileImage(
                          data: cubit.profileData,
                          onImagePicked: cubit.setProfileImage,
                        ),
                        verticalSpace(20),
                        
                        ProfileForms(
                          formKey: cubit.formKey,
                          nameController: cubit.nameController,
                          usernameController: cubit.usernameController,
                          emailController: cubit.emailController,
                          dobController: cubit.dobController,
                          ageController: cubit.ageController,
                          bloodController: cubit.bloodController,
                          phoneController: cubit.phoneController,
                          addressController: cubit.addressController,
                          nidController: cubit.nidController,
                        ),
                        verticalSpace(30),
                        
                        SaveChangesButton(
                          onPressed: () async {
                            await cubit.emitEditProfileDataStates();
                            await cubit.updateProfilePhoto();
                          }, 
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}