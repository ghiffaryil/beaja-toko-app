part of 'get_item_bloc.dart';

@freezed
class GetItemState with _$GetItemState {
  const factory GetItemState.initial() = _Initial;
  const factory GetItemState.loading() = _Loading;
  const factory GetItemState.loaded(GetItemResponseModel data) = _Loaded;
  const factory GetItemState.error(String message) = _Error;
}
