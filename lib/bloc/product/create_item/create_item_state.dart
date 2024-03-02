part of 'create_item_bloc.dart';

@freezed
class CreateItemState with _$CreateItemState {
  const factory CreateItemState.initial() = _Initial;
  const factory CreateItemState.loading() = _Loading;
  const factory CreateItemState.loaded(CreateItemResponseModel data) = _Loaded;
  const factory CreateItemState.error(String message) = _Error;
}
