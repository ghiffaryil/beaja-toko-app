import 'dart:convert';
import 'package:beaja_toko/common/constants/datasource/url_api.dart';
import 'package:beaja_toko/common/constants/datasource/variables.dart';
import 'package:beaja_toko/models/order/finish_order/finish_order_request_model.dart';
import 'package:beaja_toko/models/order/finish_order/finish_order_response_model.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class FinishOrderDatasource {
  Future<Either<String, FinishOrderResponseModel>> finishOrder(
      FinishOrderRequestModel requestModel) async {
    final token = await AuthLocalRepository().getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final uri = '${Variables.baseURL}/${UrlApi.finishOrder}';
    final request = http.Request(
      'POST',
      Uri.parse(uri),
    );

    final body = requestModel.toJson();
    request.headers.addAll(headers);
    request.body = body;

    try {
      final response = await http.Client().send(request);
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return Right(FinishOrderResponseModel.fromJson(responseBody));
      } else {
        final Map<String, dynamic> jsonDecode = json.decode(responseBody);
        final errorMessage = jsonDecode['error'] as String;
        // return const Left('Failed');
        return Left(errorMessage);
      }
    } catch (e) {
      // return Left(e.toString());
      return const Left('Error');
    }
  }
}
