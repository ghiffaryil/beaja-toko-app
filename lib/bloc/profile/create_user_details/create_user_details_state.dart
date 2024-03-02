part of 'create_user_details_bloc.dart';

@freezed
class CreateUserDetailsState with _$CreateUserDetailsState {
  const factory CreateUserDetailsState.initial() = _Initial;
  const factory CreateUserDetailsState.loading() = _Loading;
  const factory CreateUserDetailsState.loaded(String data) = _Loaded;
  const factory CreateUserDetailsState.error(String message) = _Error;
}
