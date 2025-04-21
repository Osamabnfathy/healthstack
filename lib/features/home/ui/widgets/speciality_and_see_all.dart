import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/styles.dart';


class SpecialityAndSeeAll extends StatelessWidget {
  const SpecialityAndSeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Doctors Speciality',
          style: TextStyles.font18DarkBlueSemiBold,
        ),
        const Spacer(),
        
        InkWell(
          onTap: () {},
          child: Text(
            'See All',
            style: TextStyles.font12BlueRegular,
          ),
        )
      ],
    );
  }
}
