import 'package:json_annotation/json_annotation.dart';  

part 'api_error_model.g.dart';  

@JsonSerializable(includeIfNull: false)  
class ApiErrorModel {  

  final String? message;   
  final String? code;  

  ApiErrorModel({  
    this.message,  
    this.code,  
  });  

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>  
      _$ApiErrorModelFromJson(json);  

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);   
}  