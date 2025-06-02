import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';
import 'package:healthstack/features/edit_profile/ui/widgets/profile_text_form_field.dart';


class ProfileForms extends StatefulWidget {
  final PatientProfileResponseModel? data;
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController dobController;
  final TextEditingController ageController;
  final TextEditingController bloodController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController nidController;
  final GlobalKey<FormState> formKey;
  
  const ProfileForms({
    super.key, 
    this.data,
    required this.nameController,
    required this.usernameController,
    required this.emailController,
    required this.dobController,
    required this.ageController,
    required this.bloodController,
    required this.phoneController,
    required this.addressController,
    required this.nidController,
    required this.formKey,
  });

  @override
  State<ProfileForms> createState() => _ProfileFormsState();
}

class _ProfileFormsState extends State<ProfileForms> {
  static const List<String> _bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];
  
  // Cache icons to avoid recreation
  static const Icon _personIcon = Icon(Icons.person);
  static const Icon _accountIcon = Icon(Icons.account_circle);
  static const Icon _emailIcon = Icon(Icons.email_outlined);
  static const Icon _calendarIcon = Icon(Icons.calendar_today);
  static const Icon _cakeIcon = Icon(Icons.cake);
  static const Icon _bloodIcon = Icon(Icons.bloodtype);
  static const Icon _phoneIcon = Icon(Icons.phone);
  static const Icon _locationIcon = Icon(Icons.location_on);
  static const Icon _badgeIcon = Icon(Icons.badge);

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select date of birth',
      cancelText: 'Cancel',
      confirmText: 'OK',
    );

    if (picked != null && mounted) {
      final age = _calculateAge(picked);
      final formattedDate = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

      setState(() {
        widget.dobController.text = formattedDate;
        widget.ageController.text = age.toString();
      });
    }
  }

  static int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> _pickBloodType(BuildContext context) async {
    final String? selected = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Blood Group'),
        children: _bloodTypes
            .map((type) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, type),
                  child: Text(type),
                ))
            .toList(),
      ),
    );

    if (selected != null && mounted) {
      setState(() {
        widget.bloodController.text = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          ProfileTextFormField(
            controller: widget.nameController,
            hintText: "Name",
            readOnly: false,
            suffixIcon: _personIcon,
            validator: (value) => value?.isEmpty ?? true ? 'Name is required' : null,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: widget.usernameController,
            hintText: "Username",
            readOnly: true,
            suffixIcon: _accountIcon,
            validator: (value) => value?.isEmpty ?? true ? 'Username is required' : null,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: widget.emailController,
            hintText: "Email",
            readOnly: true,
            suffixIcon: _emailIcon,
            validator: (value) => value?.isEmpty ?? true ? 'Email is required' : null,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: widget.dobController,
            hintText: "Date of Birth",
            readOnly: true,
            onTap: () => _pickDate(context),
            suffixIcon: _cakeIcon,
            validator: (value) => value?.isEmpty ?? true ? 'Date of Birth is required' : null,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: widget.ageController,
            hintText: "Age",
            readOnly: true,
            suffixIcon: _calendarIcon, 
            validator: (value) => value?.isEmpty ?? true ? 'Age is required' : null,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: widget.bloodController,
            hintText: "Blood Group",
            readOnly: true,
            onTap: () => _pickBloodType(context),
            suffixIcon: _bloodIcon,
            validator: (value) => value?.isEmpty ?? true ? 'Blood Group is required' : null,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: widget.phoneController,
            hintText: "Phone Number",
            suffixIcon: _phoneIcon,
            validator: (value) => value?.isEmpty ?? true ? 'Phone Number is required' : null,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s]')),
            ],
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: widget.addressController,
            hintText: "Address",
            suffixIcon: _locationIcon,
            validator: (value) => value?.isEmpty ?? true ? 'Address is required' : null,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: widget.nidController,
            hintText: "ID Number",
            suffixIcon: _badgeIcon,
            validator: (value) => value?.isEmpty ?? true ? 'ID Number is required' : null,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ]
          ),
        ],
      ),
    );
  }
}