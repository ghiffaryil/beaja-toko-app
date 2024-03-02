import 'dart:convert';

import 'package:beaja_toko/common/constants/datasource/url_api.dart';
import 'package:beaja_toko/common/constants/datasource/variables.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class LogoutDatasource {
  Future<Either<String, String>> logout() async {
    final token = await AuthLocalRepository().getToken();

    final headers = {
      'Authorization': token,
    };

    final request = http.Request(
      'POST',
      Uri.parse('${Variables.baseURL}/${UrlApi.logout}'),
    );

    request.headers.addAll(headers);
    try {
      final httpResponse = await http.Client().send(request);
      final responseBody = await httpResponse.stream.bytesToString();
      final Map<String, dynamic> statusResponse = json.decode(responseBody);

      // Check Status Code
      if (httpResponse.statusCode == 200) {
        final successMessage = statusResponse['message'] as String;
        return Right(successMessage);
      } else {
        final errorMessage = statusResponse['error'] as String;
        return Left(errorMessage);
      }
    } catch (e) {
      // Error
      return const Left('Logout Failed');
      // return Left(e.toString());
    }
  }
}
