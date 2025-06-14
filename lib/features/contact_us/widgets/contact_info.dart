import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoSection extends StatelessWidget {
  const ContactInfoSection({super.key});

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'medicaresvu@gmail.com',
      query: 'subject=Contact%20from%20HealthStack%20App',
    );
    
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
    }
  }

  void _launchMaps() async {
    const String query = 'Qena, Qena Governorate, Egypt';
    final Uri mapsUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    
    try {
      if (await canLaunchUrl(mapsUri)) {
        await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching maps: $e');
    }
  }

  void _copyToClipboard(BuildContext context, String text, String type) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$type copied to clipboard',
          style: TextStyles.font14LightGrayRegular,
        ),
        backgroundColor: ColorsManager.mainBlue,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: ColorsManager.lightGray.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  Icons.info_outline,
                  color: ColorsManager.mainBlue,
                  size: 20.sp,
                ),
              ),
              horizontalSpace(12),
              Text(
                'Get in Touch',
                style: TextStyles.font20DarkBlueBold,
              ),
            ],
          ),
          verticalSpace(8),
          Text(
            'Reach out to us through any of the following channels',
            style: TextStyles.font14GrayRegular,
          ),
          verticalSpace(24),
          
          // Location Info
          _buildContactItem(
            context: context,
            icon: Icons.location_on_outlined,
            title: 'Our Location',
            subtitle: 'Qena, Qena Governorate',
            onTap: _launchMaps,
            onLongPress: () => _copyToClipboard(context, 'Qena, Qena Governorate', 'Location'),
          ),
          
          verticalSpace(20),
          
          // Phone Info
          _buildContactItem(
            context: context,
            icon: Icons.phone_outlined,
            title: 'Phone Number',
            subtitle: 'Coming Soon',
            isDisabled: true,
          ),
          
          verticalSpace(20),
          
          // Email Info
          _buildContactItem(
            context: context,
            icon: Icons.email_outlined,
            title: 'Email Address',
            subtitle: 'medicaresvu@gmail.com',
            onTap: _launchEmail,
            onLongPress: () => _copyToClipboard(context, 'medicaresvu@gmail.com', 'Email'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    bool isDisabled = false,
  }) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      onLongPress: isDisabled ? null : onLongPress,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDisabled 
              ? Colors.grey.shade50 
              : ColorsManager.moreLightGray.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isDisabled 
                ? Colors.grey.shade200 
                : ColorsManager.lightGray.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isDisabled 
                    ? Colors.grey.shade100
                    : ColorsManager.mainBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                color: isDisabled 
                    ? Colors.grey.shade400
                    : ColorsManager.mainBlue,
                size: 24.sp,
              ),
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: isDisabled 
                        ? TextStyles.font14GrayRegular
                        : TextStyles.font16DarkBlueSemiBold,
                  ),
                  verticalSpace(2),
                  Text(
                    subtitle,
                    style: isDisabled 
                        ? TextStyles.font14GrayRegular.copyWith(
                            color: Colors.grey.shade400,
                          )
                        : TextStyles.font14GrayRegular,
                  ),
                ],
              ),
            ),
            if (!isDisabled) ...[
              Icon(
                Icons.arrow_forward_ios,
                color: ColorsManager.lightGray,
                size: 16.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }
}