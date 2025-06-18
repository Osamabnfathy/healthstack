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
  final String? doctorsCount;
  final String? hospitalsCount;
  const AboutUsScreen({
    super.key,
    this.doctorsCount,
    this.hospitalsCount
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: const CustomTopBar(title: 'About Us'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(10),
                    const AboutUsHero(),
                    verticalSpace(30),
                    const AboutUsContent(),
                    verticalSpace(30),
                    AboutUsStats(
                      doctorsCount: doctorsCount,
                      hospitalsCount: hospitalsCount,
                    ),
                    verticalSpace(30),
                    const AboutUsValues(),
                    verticalSpace(30),
                    const AboutUsTeam(),
                    verticalSpace(20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}