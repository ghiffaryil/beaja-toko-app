part of 'receive_order_bloc.dart';

@freezed
class ReceiveOrderEvent with _$ReceiveOrderEvent {
  const factory ReceiveOrderEvent.started() = _Started;
  const factory ReceiveOrderEvent.receiveOrder(
      ReceiveOrderRequestModel requestModel) = _ReceiveOrder;
}
