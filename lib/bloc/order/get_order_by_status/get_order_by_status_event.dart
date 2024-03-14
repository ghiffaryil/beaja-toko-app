part of 'get_order_by_status_bloc.dart';

@freezed
class GetOrderByStatusEvent with _$GetOrderByStatusEvent {
  const factory GetOrderByStatusEvent.started() = _Started;
  const factory GetOrderByStatusEvent.getOrder(
      GetOrderByStatusRequestModel requestModel) = _GetOrder;
}
