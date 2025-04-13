import 'package:flutter/material.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:healthstack/core/theming/styles.dart';

class ResetPasswordButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const ResetPasswordButton({
    super.key,
    required this.onPressed,
    this.isLoading = false, // Default to not loading
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox( // Ensure button takes full width easily
      width: double.infinity,
      height: 52, // Set height directly if desired
      child: TextButton(
        // Disable button when loading OR pass null to onPressed
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom( // Use TextButton.styleFrom
          backgroundColor: ColorsManager.mainBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          // ignore: deprecated_member_use
          disabledBackgroundColor: ColorsManager.mainBlue.withOpacity(0.5), // Visual feedback when disabled
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3,)) // Show loading indicator
            : Text(
                'Reset Password',
                style: TextStyles.font16WhiteMedium,
              ),
      ),
    );
  }
}