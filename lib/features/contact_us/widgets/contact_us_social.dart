import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIconsSection extends StatelessWidget {
  const SocialIconsSection({super.key});

  void _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsManager.mainBlue.withOpacity(0.05),
            ColorsManager.mainBlue.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsManager.mainBlue.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: ColorsManager.mainBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  FontAwesomeIcons.hashtag,
                  color: ColorsManager.mainBlue,
                  size: 32.sp,
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Follow Us',
                      style: TextStyles.font18DarkBlueBold,
                    ),
                    Text(
                      'Stay connected with us on social media',
                      style: TextStyles.font14GrayRegular,
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialButton(
                icon: FontAwesomeIcons.facebook,
                color: const Color(0xFF1877F2),
                label: 'Facebook',
                onTap: () => _launchUrl('https://www.facebook.com/profile.php?id=61577376324582'),
              ),
              _buildSocialButton(
                icon: FontAwesomeIcons.instagram,
                color: const Color(0xFFE4405F),
                label: 'Instagram',
                onTap: () => _launchUrl('https://www.instagram.com/medicaresvu/'),
              ),
              _buildSocialButton(
                icon: FontAwesomeIcons.twitter,
                color: const Color(0xFF1DA1F2),
                label: 'Twitter',
                onTap: () => _launchUrl('https://x.com/CareMedi1021'),
              ),
              _buildSocialButton(
                icon: FontAwesomeIcons.linkedin,
                color: const Color(0xFF0077B5),
                label: 'LinkedIn',
                onTap: () => _launchUrl('https://www.linkedin.com/in/medi-care-90124936b/'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: color.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: color,
              size: 26.sp,
            ),
          ),
          verticalSpace(8),
          Text(
            label,
            style: TextStyles.font12GrayRegular.copyWith(
              color: ColorsManager.darkBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}