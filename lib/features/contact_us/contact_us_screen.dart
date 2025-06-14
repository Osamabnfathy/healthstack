import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import 'package:healthstack/features/contact_us/widgets/contact_info.dart';
import 'package:healthstack/features/contact_us/widgets/contact_us_form.dart';
import 'package:healthstack/features/contact_us/widgets/contact_us_header.dart';
import 'package:healthstack/features/contact_us/widgets/contact_us_social.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.lightBlue,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            verticalSpace(20),
            const CustomTopBar(title: 'Contact Us'),
            verticalSpace(20),
            const ContactHeader(),
            verticalSpace(30),
            const ContactInfoSection(),
            verticalSpace(30),
            const ContactForm(),
            verticalSpace(40),
            const SocialIconsSection(),
            verticalSpace(30),
          ],
        ),
      ),
    );
  }
}