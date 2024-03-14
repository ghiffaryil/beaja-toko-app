import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:beaja_toko/common/constants/datasource/url_api.dart';
import 'package:beaja_toko/common/constants/datasource/variables.dart';
import 'package:beaja_toko/models/profile/get_user_details/get_user_detail_response_model.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserDetailsDatasource {
  Future<Either<String, GetUserDetailsResponseModel>> getUserDetails() async {
    // Get value from Repository
    final token = await AuthLocalRepository().getToken();
    final email = await AuthLocalRepository().getUserEmail();

    if (token.isEmpty) {
      return const Left('Failed');
    } else {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      final body = {
        "email": email,
      };

      final request = http.Request(
        'GET',
        Uri.parse('${Variables.baseURL}/${UrlApi.getUserDetails}'),
      );

      request.headers.addAll(headers);
      request.body = jsonEncode(body);

      try {
        final response = await http.Client().send(request);
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> jsonDecode = json.decode(responseBody);

        print('Body : $responseBody');

        // Check response status code
        if (response.statusCode == 200) {
          return Right(GetUserDetailsResponseModel.fromJson(responseBody));
        } else {
          final errorMessage = jsonDecode['error'] as String;
          return Left(errorMessage);
          // return const Left('Failed');
        }
      } catch (e) {
        print(e.toString());
        return Left(e.toString());
        // return const Left('Error');
      }
    }
  }
}
