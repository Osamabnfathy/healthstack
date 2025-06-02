import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstack/features/edit_profile/data/repos/edit_profile_data_repo.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';
import 'package:healthstack/features/edit_profile/logic/cubit/edit_profile_data_state.dart';
import 'package:healthstack/features/edit_profile/data/models/edit_profile_data_request_body.dart';

class EditProfileDataCubit extends Cubit<EditProfileDataState> {
  final EditProfileDataRepo _editProfileDataRepo;
  EditProfileDataCubit(this._editProfileDataRepo) : super(const EditProfileDataState.initial());
  
  PatientProfileResponseModel? profileData;
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final ageController = TextEditingController();
  final bloodController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final nidController = TextEditingController();
  
  final formKey = GlobalKey<FormState>();

  File? profileImageFile;

  void initWithProfile(PatientProfileResponseModel? data) {
    profileData = data;
    nameController.text = data?.name ?? '';
    usernameController.text = data?.username ?? '';
    emailController.text = data?.email ?? '';
    dobController.text = data?.dob ?? '';
    ageController.text = data?.age?.toString() ?? '';
    bloodController.text = data?.bloodGroup ?? '';
    phoneController.text = data?.phoneNumber?.toString() ?? '';
    addressController.text = data?.address ?? '';
    nidController.text = data?.nid ?? '';
  }

  void setProfileImage(File? file) {
    profileImageFile = file;
    emit(state);
  }
  
  Future<void> updateProfilePhoto() async {
    if (profileImageFile == null) return;
    emit(const EditProfileDataState.loading());

    final response = await _editProfileDataRepo.updateProfilePhoto(profileImageFile!);

    response.when(
      success: (imageUrl) {
        print('Image URL: $imageUrl');
      },
      failure: (error) {
        emit(EditProfileDataState.error(error: error.apiErrorModel.message ?? ''));
      },
    );
  }

  Future<void> emitEditProfileDataStates() async {
    if (!formKey.currentState!.validate()) return;

    emit(const EditProfileDataState.loading());


    final requestBody = EditProfileDataRequestBody(
      name: nameController.text.trim(),
      username: usernameController.text.trim(),
      email: emailController.text.trim(),
      dob: dobController.text.trim(),
      age: int.tryParse(ageController.text.trim()),
      bloodGroup: bloodController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      nid: nidController.text.trim(),
    );

    final response = await _editProfileDataRepo.editProfile(requestBody);

    response.when(
      success: (editProfileDataResponse) async {
        emit(EditProfileDataState.success(editProfileDataResponse));
      },
      failure: (error) {
        emit(EditProfileDataState.error(error: error.apiErrorModel.message ?? ''));
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    dobController.dispose();
    ageController.dispose();
    bloodController.dispose();
    phoneController.dispose();
    addressController.dispose();
    nidController.dispose();
    return super.close();
  }
}