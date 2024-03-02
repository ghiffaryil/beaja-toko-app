part of 'create_item_bloc.dart';

@freezed
class CreateItemEvent with _$CreateItemEvent {
  const factory CreateItemEvent.started() = _Started;
  const factory CreateItemEvent.createItem(
      CreateItemRequestModel requestModel) = _CreateItem;
}
