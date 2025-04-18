import 'package:flutter/material.dart';
import 'package:healthstack/core/routing/routes.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:healthstack/core/helpers/extensions.dart';


class DoctorsAndSeeAll extends StatelessWidget {
  const DoctorsAndSeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Doctors',
          style: TextStyles.font18DarkBlueSemiBold,
        ),
        const Spacer(),
        
        InkWell(
          onTap: () {
            context.pushNamed(Routes.doctorsScreen);
          },
          child: Text(
            'See All',
            style: TextStyles.font12BlueRegular
          ),
        )
      ],
    );
  }
}
