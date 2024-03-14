import 'dart:convert';

import 'package:beaja_toko/common/constants/datasource/url_api.dart';
import 'package:beaja_toko/common/constants/datasource/variables.dart';
import 'package:beaja_toko/models/auth/login/login_request_model.dart';
import 'package:beaja_toko/models/auth/login/login_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class LoginDatasource {
  Future<Either<String, LoginResponseModel>> login(
      LoginRequestModel requestModel) async {
    // Set Headers variable
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = requestModel.toJson();
    final request = http.Request(
      'POST',
      Uri.parse('${Variables.baseURL}/${UrlApi.login}'),
    );

    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    try {
      final httpResponse = await http.Client().send(request);
      final responseBody = await httpResponse.stream.bytesToString();
      final Map<String, dynamic> jsonResponse = json.decode(responseBody);

      // Check Status Code
      if (httpResponse.statusCode == 200) {
        print(jsonResponse);
        return Right(LoginResponseModel.fromJson(jsonResponse));
      } else {
        final errorMessage = jsonResponse['error'];
        // print(errorMessage);
        return Left(errorMessage);
      }
    } catch (e) {
      // Error
      // return Left('Login Failed');
      return Left(e.toString());
    }
  }
}
