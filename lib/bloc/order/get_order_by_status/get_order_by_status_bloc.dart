import 'package:beaja_toko/datasource/order/get_order_by_status/get_order_by_status_datasource.dart';
import 'package:beaja_toko/models/order/get_order_by_status/get_order_by_status_request_model.dart';
import 'package:beaja_toko/models/order/get_order_by_status/get_order_by_status_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_order_by_status_event.dart';
part 'get_order_by_status_state.dart';
part 'get_order_by_status_bloc.freezed.dart';

class GetOrderByStatusBloc
    extends Bloc<GetOrderByStatusEvent, GetOrderByStatusState> {
  GetOrderByStatusBloc() : super(_Initial()) {
    on<_GetOrder>((event, emit) async {
      final response =
          await GetOrderByStatusDatasource().getOrder(event.requestModel);
      response.fold(
        (error) => emit(_Error(error)),
        (data) {
          emit(_Loaded(data));
        },
      );
    });
  }
}
