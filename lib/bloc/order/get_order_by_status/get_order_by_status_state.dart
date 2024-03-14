part of 'get_order_by_status_bloc.dart';

@freezed
class GetOrderByStatusState with _$GetOrderByStatusState {
  const factory GetOrderByStatusState.initial() = _Initial;
  const factory GetOrderByStatusState.loading() = _Loading;
  const factory GetOrderByStatusState.loaded(
      GetOrderByStatusResponseModel data) = _Loaded;
  const factory GetOrderByStatusState.error(String message) = _Error;
}
