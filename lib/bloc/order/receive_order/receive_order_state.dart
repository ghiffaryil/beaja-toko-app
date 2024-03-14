part of 'receive_order_bloc.dart';

@freezed
class ReceiveOrderState with _$ReceiveOrderState {
  const factory ReceiveOrderState.initial() = _Initial;
  const factory ReceiveOrderState.loading() = _Loading;
  const factory ReceiveOrderState.loaded(ReceiveOrderResponseModel data) =
      _Loaded;
  const factory ReceiveOrderState.error(String message) = _Error;
}
