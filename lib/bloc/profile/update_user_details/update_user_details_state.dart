part of 'update_user_details_bloc.dart';

@freezed
class UpdateUserDetailsState with _$UpdateUserDetailsState {
  const factory UpdateUserDetailsState.initial() = _Initial;
  const factory UpdateUserDetailsState.loading() = _Loading;
  const factory UpdateUserDetailsState.loaded(String data) = _Loaded;
  const factory UpdateUserDetailsState.error(String message) = _Error;
}
