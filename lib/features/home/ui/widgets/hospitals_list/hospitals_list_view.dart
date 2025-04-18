import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';


class HospitalsListView extends StatefulWidget {
  const HospitalsListView({super.key});

  @override
  State<HospitalsListView> createState() => _SpecialityListViewState();
}

class _SpecialityListViewState extends State<HospitalsListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8, // widget.specializationDataList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsetsDirectional.only(
              start: index == 0 ? 0 : 18.w,
            ),
            
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: ColorsManager.lightBlue,
                  child: SvgPicture.asset(
                    'assets/svgs/general_speciality.svg',
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
                verticalSpace(8),
                
                Text(
                  "hospital name",
                  style: TextStyles.font12DarkBlueRegular,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

          // return GestureDetector(
          //   onTap: () {
          //     setState(() {
          //       selectedSpecializationIndex = index;
          //     });
          //     // context.read<HomeCubit>().getDoctorsList(
          //     //       specializationId: widget.specializationDataList[index]?.id,
          //     //     );
          //   },
          //   child: SpecialityListViewItem(
          //     specializationsData: widget.specializationDataList[index],
          //     itemIndex: index,
          //     selectedIndex: selectedSpecializationIndex,
          //   ),
          // );