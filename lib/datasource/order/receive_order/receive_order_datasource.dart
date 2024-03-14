import 'dart:convert';
import 'package:beaja_toko/common/constants/datasource/url_api.dart';
import 'package:beaja_toko/common/constants/datasource/variables.dart';
import 'package:beaja_toko/models/order/receive_order/receive_order_request_model.dart';
import 'package:beaja_toko/models/order/receive_order/receive_order_response_model.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class ReceiveOrderDatasource {
  Future<Either<String, ReceiveOrderResponseModel>> receiveOrder(
      ReceiveOrderRequestModel requestModel) async {
    final token = await AuthLocalRepository().getToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final request = http.Request(
      'GET',
      Uri.parse('${Variables.baseURL}/${UrlApi.receiveOrder}'),
    );

    final body = requestModel.toJson();
    request.headers.addAll(headers);
    request.body = jsonEncode(body);

    try {
      final response = await http.Client().send(request);
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return Right(ReceiveOrderResponseModel.fromJson(responseBody));
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
