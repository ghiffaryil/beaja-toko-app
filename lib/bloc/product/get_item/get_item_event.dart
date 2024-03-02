part of 'get_item_bloc.dart';

@freezed
class GetItemEvent with _$GetItemEvent {
  const factory GetItemEvent.started() = _Started;
  const factory GetItemEvent.getItem(GetItemRequestModel requestModel) =
      _GetItem;
}
