import 'package:beaja_toko/datasource/order/finish_order/finish_order_datasource.dart';
import 'package:beaja_toko/models/order/finish_order/finish_order_request_model.dart';
import 'package:beaja_toko/models/order/finish_order/finish_order_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'finish_order_event.dart';
part 'finish_order_state.dart';
part 'finish_order_bloc.freezed.dart';

class FinishOrderBloc extends Bloc<FinishOrderEvent, FinishOrderState> {
  FinishOrderBloc() : super(_Initial()) {
    on<_FinishOrder>((event, emit) async {
      final response =
          await FinishOrderDatasource().finishOrder(event.requestModel);
      response.fold(
        (error) => emit(_Error(error)),
        (data) {
          emit(_Loaded(data));
        },
      );
    });
  }
}
