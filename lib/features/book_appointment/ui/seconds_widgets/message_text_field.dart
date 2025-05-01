import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageTextField extends StatelessWidget {
  final TextEditingController messageController;

  const MessageTextField({
    super.key,
    required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Message to Doctor",
          style: TextStyles.font16DarkBlueBold,
        ),
        verticalSpace(15),
        
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
              
          child:TextField(
            controller: messageController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Type your message here...",
              hintStyle: TextStyles.font14GrayRegular,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: ColorsManager.mainBlue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}