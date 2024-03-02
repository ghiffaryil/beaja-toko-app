part of 'create_user_details_bloc.dart';

@freezed
class CreateUserDetailsEvent with _$CreateUserDetailsEvent {
  const factory CreateUserDetailsEvent.started() = _Started;
  const factory CreateUserDetailsEvent.createUserDetails(
          CreateUserDetailsRequestModel requestModel, int userId) =
      _CreateUserDetails;
}
