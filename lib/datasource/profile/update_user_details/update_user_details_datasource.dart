import 'dart:convert';

import 'package:beaja_toko/common/constants/datasource/url_api.dart';
import 'package:beaja_toko/common/constants/datasource/variables.dart';
import 'package:beaja_toko/models/profile/update_user_details/update_user_details_request_model.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class UpdateUserDetailsDatasource {
  Future<Either<String, String>> update(
      UpdateUserDetailsRequestModel requestModel, int userId) async {
    final token = await AuthLocalRepository().getToken();

    final headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': token,
    };

    final uri = '${Variables.baseURL}/${UrlApi.updateUserDetails}/$userId';
    // final uri = '${Variables.baseURL}/user/update-user-details/$userId';
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(uri),
    );
    print(uri);

    request.headers.addAll(headers);
    request.fields.addAll(requestModel.toFormData());

    try {
      final httpResponse = await request.send();
      final response = await http.Response.fromStream(httpResponse);
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final String responseMessage = jsonResponse['message'];
        return Right(responseMessage);
      } else {
        final responseMessage = jsonResponse['error'];
        return Left(responseMessage);
      }
    } catch (e) {
      // Error
      return Left(e.toString());
    }
  }
}
