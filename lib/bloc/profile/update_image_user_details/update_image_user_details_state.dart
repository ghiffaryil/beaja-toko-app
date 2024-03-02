part of 'update_image_user_details_bloc.dart';

@freezed
class UpdateImageUserDetailsState with _$UpdateImageUserDetailsState {
  const factory UpdateImageUserDetailsState.initial() = _Initial;
  const factory UpdateImageUserDetailsState.loading() = _Loading;
  const factory UpdateImageUserDetailsState.loaded(String data) = _Loaded;
  const factory UpdateImageUserDetailsState.error(String message) = _Error;
}
