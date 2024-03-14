import 'dart:convert';

import 'package:beaja_toko/common/constants/datasource/url_api.dart';
import 'package:beaja_toko/common/constants/datasource/variables.dart';
import 'package:beaja_toko/models/auth/register/register_request_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class RegisterDatasource {
  Future<Either<String, String>> register(
      RegisterRequestModel requestModel) async {
    final headers = {
      // 'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final body = requestModel.toJson();
    final request = http.Request(
      'POST',
      Uri.parse('${Variables.baseURL}/${UrlApi.register}'),
    );

    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    try {
      final httpResponse = await http.Client().send(request);
      final responseBody = await httpResponse.stream.bytesToString();
      final Map<String, dynamic> statusResponse = json.decode(responseBody);

      if (httpResponse.statusCode == 200) {
        final successMessage = statusResponse['message'] as String;
        return Right(successMessage);
      } else {
        final errorMessage = statusResponse['error'] as String;
        return Left(errorMessage);
      }
    } catch (e) {
      // Error
      return Left(e.toString());
    }
  }
}
