import 'package:flutter/material.dart';
import 'package:healthstack/core/helpers/spacing.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';
import 'package:healthstack/features/edit_profile/ui/widgets/profile_text_form_field.dart';


class ProfileForms extends StatefulWidget {
  final PatientProfileResponseModel? data;
  
  const ProfileForms({super.key, this.data});

  @override
  State<ProfileForms> createState() => _ProfileFormsState();
}

class _ProfileFormsState extends State<ProfileForms> {
  late TextEditingController _dobController;
  late TextEditingController _bloodController;
  late TextEditingController _ageController;
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _nidController;
  
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

  @override
void initState() {
  super.initState();
  _dobController = TextEditingController(text: widget.data?.dob ?? '');
  _bloodController = TextEditingController(text: widget.data?.bloodGroup ?? '');
  _ageController = TextEditingController(text: widget.data?.age?.toString() ?? '',);
  _nameController = TextEditingController(text: widget.data?.name ?? '');
  _usernameController = TextEditingController(text: widget.data?.username ?? '');
  _emailController = TextEditingController(text: widget.data?.email ?? '');
  _phoneController = TextEditingController(text: widget.data?.phoneNumber?.toString() ?? '');
  _addressController = TextEditingController(text: widget.data?.address ?? '');
  _nidController = TextEditingController(text: widget.data?.nid ?? '');
}

  @override
  void dispose() {
    _dobController.dispose();
    _bloodController.dispose();
    _ageController.dispose();
    super.dispose();
  }

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
        _dobController.text = formattedDate;
        _ageController.text = age.toString();
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
        _bloodController.text = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          ProfileTextFormField(
            controller: _nameController,
            hintText: "Name",
            readOnly: false,
            suffixIcon: _personIcon,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: _usernameController,
            hintText: "Username",
            readOnly: true,
            suffixIcon: _accountIcon,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: _emailController,
            hintText: "Email",
            readOnly: true,
            suffixIcon: _emailIcon,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: _dobController,
            hintText: "Date of Birth",
            readOnly: true,
            onTap: () => _pickDate(context),
            suffixIcon: _calendarIcon,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: _ageController,
            hintText: "Age",
            readOnly: true,
            suffixIcon: _cakeIcon,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: _bloodController,
            hintText: "Blood Group",
            readOnly: true,
            onTap: () => _pickBloodType(context),
            suffixIcon: _bloodIcon,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: _phoneController,
            hintText: "Phone Number",
            suffixIcon: _phoneIcon,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: _addressController,
            hintText: "Address",
            suffixIcon: _locationIcon,
          ),
          verticalSpace(10),
          
          ProfileTextFormField(
            controller: _nidController,
            hintText: "ID Number",
            suffixIcon: _badgeIcon,
          ),
        ],
      ),
    );
  }
}