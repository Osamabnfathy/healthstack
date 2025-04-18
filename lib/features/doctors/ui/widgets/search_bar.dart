import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';


class SearchAndFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onFilterPressed;

  const SearchAndFilterBar({
    super.key,
    required this.searchController,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyles.font15DarkBlueMedium
                  .copyWith(color: ColorsManager.lightGray),
              prefixIcon: const Icon(
                Icons.search,
                color: ColorsManager.lightGray,
              ),
              
              filled: true,
              fillColor: ColorsManager.moreLighterGray,
              // contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        horizontalSpace(12),
        
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: ColorsManager.moreLightGray,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: ColorsManager.gray.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          
          child: IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: onFilterPressed,
          ),
        ),
      ],
    );
  }
}