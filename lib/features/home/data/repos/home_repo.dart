import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:healthstack/core/networking/api_result.dart';
import 'package:healthstack/core/networking/api_error_handler.dart';
import 'package:healthstack/features/home/data/apis/home_api_services.dart';
import 'package:healthstack/features/home/data/models/doctors_response_model.dart';
import 'package:healthstack/features/home/data/models/hospitals_response_model.dart';
import 'package:healthstack/features/home/data/models/departments_response_model.dart';
import 'package:healthstack/features/home/data/models/patient_profile_response_model.dart';

class HomeRepo {
  final HomeApiServices _homeApiServices;

  HomeRepo(this._homeApiServices);

  Future<ApiResult<List<DepartmentsResponseModel>>> getDepartments() async {
    try {
      final response = await _homeApiServices.getDepartments();
      final departments = await compute(parseDepartments, jsonEncode(response));
      return ApiResult.success(departments);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<DoctorsResponseModel>>> getDoctors() async {
    try {
      final response = await _homeApiServices.getDoctors();
      final doctors = await compute(parseDoctors, jsonEncode(response));
      return ApiResult.success(doctors);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<List<HospitalsResponseModel>>> getHospitals() async {
    try {
      final response = await _homeApiServices.getHospitals();
      final hospitals = await compute(parseHospitals, jsonEncode(response));
      return ApiResult.success(hospitals);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<PatientProfileResponseModel>> getPatientProfile() async {
    try {
      final response = await _homeApiServices.getPatientProfile();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}

// Top-level parsing functions for compute()
List<DepartmentsResponseModel> parseDepartments(String jsonStr) {
  final List<dynamic> jsonList = jsonDecode(jsonStr);
  return jsonList.map((e) => DepartmentsResponseModel.fromJson(e)).toList();
}

List<DoctorsResponseModel> parseDoctors(String jsonStr) {
  final List<dynamic> jsonList = jsonDecode(jsonStr);
  return jsonList.map((e) => DoctorsResponseModel.fromJson(e)).toList();
}

List<HospitalsResponseModel> parseHospitals(String jsonStr) {
  final List<dynamic> jsonList = jsonDecode(jsonStr);
  return jsonList.map((e) => HospitalsResponseModel.fromJson(e)).toList();
}