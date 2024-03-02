import 'dart:convert';

import 'package:beaja_toko/common/constants/datasource/url_api.dart';
import 'package:beaja_toko/common/constants/datasource/variables.dart';
import 'package:beaja_toko/models/profile/create_user_details/create_user_details_request_model.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class CreateUserDetailsDatasource {
  Future<Either<String, String>> createUserDetails(
      CreateUserDetailsRequestModel requestModel, int userId) async {
    final token = await AuthLocalRepository().getToken();

    final headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': token,
    };
    // print(token);

    final uri = '${Variables.baseURL}/${UrlApi.createUserDetails}';
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(uri),
    );
    request.headers.addAll(headers);
    request.fields.addAll(requestModel.toFormData());
    if (requestModel.image != null) {
      request.files.add(
          await http.MultipartFile.fromPath('image', requestModel.image!.path));
    }

    try {
      final httpResponse = await request.send();
      final response = await http.Response.fromStream(httpResponse);
      if (response.statusCode == 413) {
        // return Left(response.reasonPhrase.toString());
        return const Left('Gambar terlalu besar!');
      } else {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          final String responseMessage = jsonResponse['message'];
          return Right(responseMessage);
        } else {
          final responseMessage = jsonResponse['error'];
          return Left(responseMessage);
        }
      }
    } catch (e) {
      // Error
      return Left(e.toString());
    }
  }
}
