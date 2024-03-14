part of 'finish_order_bloc.dart';

@freezed
class FinishOrderState with _$FinishOrderState {
  const factory FinishOrderState.initial() = _Initial;
  const factory FinishOrderState.loading() = _Loading;
  const factory FinishOrderState.loaded(FinishOrderResponseModel data) =
      _Loaded;
  const factory FinishOrderState.error(String message) = _Error;
}
