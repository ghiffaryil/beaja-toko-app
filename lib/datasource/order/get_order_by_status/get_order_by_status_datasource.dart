import 'dart:convert';
import 'package:beaja_toko/common/constants/datasource/url_api.dart';
import 'package:beaja_toko/common/constants/datasource/variables.dart';
import 'package:beaja_toko/models/order/get_order_by_status/get_order_by_status_request_model.dart';
import 'package:beaja_toko/models/order/get_order_by_status/get_order_by_status_response_model.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class GetOrderByStatusDatasource {
  Future<Either<String, GetOrderByStatusResponseModel>> getOrder(
      GetOrderByStatusRequestModel requestModel) async {
    final token = await AuthLocalRepository().getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final request = http.Request(
      'GET',
      Uri.parse('${Variables.baseURL}/${UrlApi.getOrderByStatus}'),
    );

    final body = requestModel.toJson();
    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    try {
      final response = await http.Client().send(request);
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return Right(GetOrderByStatusResponseModel.fromJson(responseBody));
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
