part of 'get_user_details_bloc.dart';

@freezed
class GetUserDetailsState with _$GetUserDetailsState {
  const factory GetUserDetailsState.initial() = _Initial;
  const factory GetUserDetailsState.loading() = _Loading;
  const factory GetUserDetailsState.loaded(GetUserDetailsResponseModel data) =
      _Loaded;
  const factory GetUserDetailsState.error(String message) = _Error;
}
