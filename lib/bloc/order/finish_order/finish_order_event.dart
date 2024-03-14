part of 'finish_order_bloc.dart';

@freezed
class FinishOrderEvent with _$FinishOrderEvent {
  const factory FinishOrderEvent.started() = _Started;
  const factory FinishOrderEvent.finishOrder(
      FinishOrderRequestModel requestModel) = _FinishOrder;
}
