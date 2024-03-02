part of 'update_user_details_bloc.dart';

@freezed
class UpdateUserDetailsEvent with _$UpdateUserDetailsEvent {
  const factory UpdateUserDetailsEvent.started() = _Started;
  const factory UpdateUserDetailsEvent.update(
      UpdateUserDetailsRequestModel requestModel, int userId) = _Update;
}
