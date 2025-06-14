import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/widgets/custom_top_bar.dart';
import 'package:healthstack/features/about_us/widgets/about_us_animation.dart';
import 'package:healthstack/features/about_us/widgets/about_us_content.dart';
import 'package:healthstack/features/about_us/widgets/about_us_stats.dart';
import 'package:healthstack/features/about_us/widgets/about_us_values.dart';
import 'package:healthstack/features/about_us/widgets/about_us_team.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const CustomTopBar(title: 'About Us'),
              ),
              verticalSpace(20),
              const AboutUsHero(),
              verticalSpace(30),
              const AboutUsContent(),
              verticalSpace(30),
              const AboutUsStats(),
              verticalSpace(30),
              const AboutUsValues(),
              verticalSpace(30),
              const AboutUsTeam(),
              verticalSpace(30),
            ],
          ),
        ),
      ),
    );
  }
}