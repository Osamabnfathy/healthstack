import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/styles.dart';

class DepartmentsAndSeeAll extends StatelessWidget {
  const DepartmentsAndSeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Departments',
          style: TextStyles.font18DarkBlueSemiBold,
        ),
        
        Spacer(),
        
        TextButton(
          onPressed: () {},
          child: Text(
          'See All',
          style: TextStyles.font13BlueSemiBold,
          ),
        ),
      ],
    );
  }
}
