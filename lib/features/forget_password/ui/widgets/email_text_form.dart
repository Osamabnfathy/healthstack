import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/app_regex.dart'; // Make sure this import is correct
import 'package:healthstack/core/widgets/app_text_form_field.dart'; // Make sure this import is correct

class EmailTextForm extends StatelessWidget {
  // Accept the controller as a parameter
  final TextEditingController controller;

  const EmailTextForm({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // No need for a Form widget here; the main screen will have it.
    return AppTextFormField(
      hintText: 'Enter your Email',
      keyboardType: TextInputType.emailAddress,
      controller: controller, // Use the passed controller
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address.'; // Specific message for empty
        }
        if (!AppRegex.isEmailValid(value)) {
          // Assuming AppRegex.isEmailValid exists and works correctly
          return 'Please enter a valid email address.'; // Specific message for invalid format
        }
        return null; // Return null if validation passes
      },
    );
  }
}