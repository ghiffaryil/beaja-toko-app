import 'dart:convert';

import 'package:beaja_toko/common/constants/datasource/url_api.dart';
import 'package:beaja_toko/common/constants/datasource/variables.dart';
import 'package:beaja_toko/models/profile/update_user_details/update_image_user_details_request_model.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class UpdateImageUserDetailsDatasource {
  Future<Either<String, String>> update(
      UpdateImageUserDetailsRequestModel requestModel, int userId) async {
    final token = await AuthLocalRepository().getToken();

    final headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': token,
    };

    // UPDATE IMAGE TO ANOTHER API
    final uriUpdateImage =
        '${Variables.baseURL}/${UrlApi.updateUserDetailsImage}/$userId';
    final requestImage = http.MultipartRequest(
      'POST',
      Uri.parse(uriUpdateImage),
    );
    requestImage.headers.addAll(headers);
    requestImage.files.add(
        await http.MultipartFile.fromPath('image', requestModel.image!.path));

    try {
      final httpResponse = await requestImage.send();
      final response = await http.Response.fromStream(httpResponse);
      if (response.statusCode == 413) {
        // return Left(response.reasonPhrase.toString());
        return const Left('Gambar terlalu besar!');
      } else {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          final String responseMessage = jsonResponse['message'];
          print(responseMessage);
          return Right(responseMessage);
        } else {
          final responseMessage = jsonResponse['error'];
          print(responseMessage);
          return Left(responseMessage);
        }
      }
    } catch (e) {
      // Error
      return Left(e.toString());
    }
  }
}
