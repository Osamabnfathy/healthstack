import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:healthstack/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';


class ProfileImage extends StatefulWidget {
  final PatientProfileResponseModel? data;
  final void Function(File?)? onImagePicked; 
  
  const ProfileImage({super.key, this.data, this.onImagePicked});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
  
    if (picked != null) {
      final file = File(picked.path);
      final fileSize = await file.length();
      final fileExtension = picked.path.split('.').last.toLowerCase();
  
      if (fileSize > 2 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image must be less than 2 MB.')),
        );
        return;
      }

      if (fileExtension != 'jpg' && fileExtension != 'jpeg' && fileExtension != 'png') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Only JPG and PNG images are allowed.')),
        );
        return;
      }
  
      setState(() {
        _pickedImage = file;
      });
      widget.onImagePicked?.call(_pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = _pickedImage != null
      ? Image.file(_pickedImage!, fit: BoxFit.cover, width: 80.w, height: 80.h)
      : (widget.data?.featuredImage != null && widget.data!.featuredImage!.isNotEmpty
          ? Image.network(widget.data!.featuredImage!, fit: BoxFit.cover, width: 80.w, height: 80.h)
          : SvgPicture.asset('assets/svgs/general_speciality.svg', fit: BoxFit.cover, height: 50.h, width: 50.w));

  
    return  Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 90.w,
              height: 90.h,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.r),
                child: imageWidget,
              ),
            ),
            
            InkWell(
              onTap: _pickImage,
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.edit, size: 16.sp, color: ColorsManager.mainBlue),
              ),
            ),
          ],
        ),
      ],
    );
     
    
  }
}
