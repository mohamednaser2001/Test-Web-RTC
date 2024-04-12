import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
 // int? statusCode;
  String? statusMessage;
  // Map<String, dynamic>? errors;
  ErrorMessageModel({
   // required this.statusCode,
    required this.statusMessage,
    // required this.errors,
  });

  ErrorMessageModel.fromJson(Map<String, dynamic> json) {
     // statusCode= json["status"]??400;
      statusMessage= json["message"]??'';
      // errors= json["errors"];
  }


  @override
  List<Object?> get props => [
   // statusCode,
    statusMessage,
    // errors,
  ];
}