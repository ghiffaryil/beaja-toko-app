import 'package:beaja_toko/datasource/order/receive_order/receive_order_datasource.dart';
import 'package:beaja_toko/models/order/receive_order/receive_order_request_model.dart';
import 'package:beaja_toko/models/order/receive_order/receive_order_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'receive_order_event.dart';
part 'receive_order_state.dart';
part 'receive_order_bloc.freezed.dart';

class ReceiveOrderBloc extends Bloc<ReceiveOrderEvent, ReceiveOrderState> {
  ReceiveOrderBloc() : super(_Initial()) {
    on<_ReceiveOrder>((event, emit) async {
      final response =
          await ReceiveOrderDatasource().receiveOrder(event.requestModel);
      response.fold(
        (error) => emit(_Error(error)),
        (data) {
          emit(_Loaded(data));
        },
      );
    });
  }
}
