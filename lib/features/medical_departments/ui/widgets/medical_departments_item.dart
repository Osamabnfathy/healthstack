import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';

class MedicalDepartmentsItem extends StatelessWidget {
  final String iconAsset;
  final String name;
  final VoidCallback onTap;
  final int? doctorsCount;
  final String? hospitalName;

  MedicalDepartmentsItem({
    super.key,
    required this.iconAsset,
    required this.name,
    required this.onTap,
    this.doctorsCount,
    this.hospitalName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundColor: ColorsManager.lightBlue,
            child: _buildIcon(),
          ),
          verticalSpace(8),
          Text(
            name,
            style: TextStyles.font13DarkBlueMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (hospitalName != null) ...[
            verticalSpace(4),
            Text(
              hospitalName!,
              style: TextStyles.font11GreyRegular,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (doctorsCount != null) ...[
            verticalSpace(4),
            Text(
              '$doctorsCount Doctor${doctorsCount != 1 ? 's' : ''}',
              style: TextStyles.font11GreyRegular,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (iconAsset.isEmpty) {
      return Icon(
        Icons.local_hospital,
        size: 70.w,
        color: ColorsManager.mainBlue,
      );
    }

    if (iconAsset.startsWith('http://') || iconAsset.startsWith('https://')) {
      // Handle network image
      if (iconAsset.toLowerCase().endsWith('.svg')) {
        // For SVG from network
        return SvgPicture.network(
          iconAsset,
          width: 70.w,
          height: 70.h,
          placeholderBuilder: (context) => placeholderImage,
        );
      } else {
        return ClipOval(
          child: Image.network(
            iconAsset,
            width: 70.w,
            height: 70.h,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                width: 70.w,
                height: 70.h,
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    strokeWidth: 2,
                    color: ColorsManager.mainBlue,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return placeholderImage;
            },
          ),
        );
      }
    } else {
      // Handle local asset (fallback to original behavior)
      if (iconAsset.toLowerCase().endsWith('.svg')) {
        return SvgPicture.asset(
          iconAsset,
          width: 70.w,
          height: 70.h,
        );
      } else {
        return Image.asset(
          iconAsset,
          width: 70.w,
          height: 70.h,
          fit: BoxFit.cover,
        );
      }
    }
  }
  final Widget placeholderImage = Image.asset(
    'assets/icons/general.png', 
    height: 75.h, 
    width: 75.w,
    fit: BoxFit.cover, 
  );  
}