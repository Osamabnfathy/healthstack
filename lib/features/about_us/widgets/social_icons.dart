import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons({super.key});

  void _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        // Handle case where URL can't be launched
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      // Handle any errors that occur
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Follow Us on Social Media',
          style: TextStyles.font20DarkBlueBold,
        ),
        verticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => _launchUrl('https://www.facebook.com/profile.php?id=61577376324582'),
              child: Icon(
                FontAwesomeIcons.facebook,
                color: ColorsManager.mainBlue,
                size: 35.sp,
              ),
            ),
            horizontalSpace(15),
            
            InkWell(
              onTap: () => _launchUrl('https://www.instagram.com/medicaresvu/'),
              child: Icon(
                FontAwesomeIcons.instagram,
                color: ColorsManager.mainBlue,
                size: 35.sp,
              ),
            ),
            horizontalSpace(15),
            
            InkWell(
              onTap: () => _launchUrl('https://x.com/CareMedi1021'),
              child: Icon(
                FontAwesomeIcons.twitter,
                color: ColorsManager.mainBlue,
                size: 35.sp,
              ),
            ),
            horizontalSpace(15),
            
            InkWell(
              onTap: () => _launchUrl('https://www.linkedin.com/in/medi-care-90124936b/'),
              child: Icon(
                FontAwesomeIcons.linkedin,
                color: ColorsManager.mainBlue,
                size: 35.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}