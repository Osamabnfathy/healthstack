import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/extensions.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/styles.dart';

class DepartmentDoctorsAndSeeall extends StatelessWidget {
  const DepartmentDoctorsAndSeeall({super.key});

  @override
   Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Department Doctors',
          style: TextStyles.font18DarkBlueSemiBold,
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            context.pushNamed(Routes.doctorsScreen);
          },
        child: Text(
          'See All',
          style: TextStyles.font12BlueRegular,
        ),
        )
      ],
    );
  }
}
