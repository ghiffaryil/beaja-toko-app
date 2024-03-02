import 'dart:convert';

import 'package:beaja_toko/common/constants/datasource/url_api.dart';
import 'package:beaja_toko/common/constants/datasource/variables.dart';
import 'package:beaja_toko/models/auth/verify_otp/verify_otp_request_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class VerifyOtpDatasource {
  Future<Either<String, String>> verifyOtp(
      VerifyOtpRequestModel requestModel) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final body = requestModel.toJson();
    final request = http.Request(
      'POST',
      Uri.parse('${Variables.baseURL}/${UrlApi.verifyOtp}'),
    );
    request.headers.addAll(headers);
    request.body = jsonEncode(body);
    try {
      final httpResponse = await http.Client().send(request);
      // Get Rsponse Body
      final responseBody = await httpResponse.stream.bytesToString();
      // Decode Response Body
      final Map<String, dynamic> statusResponse = json.decode(responseBody);
      // Check Status Code
      if (httpResponse.statusCode == 200) {
        final successMessage = statusResponse['message'] as String;
        // Return response to BLOC (Right Response) loaded
        return Right(successMessage);
      } else {
        final errorMessage = statusResponse['error'] as String;
        // Return response to BLOC (Left Response) error
        return Left(errorMessage);
      }
    } catch (e) {
      // Error
      return Left(e.toString());
    }
  }
}
