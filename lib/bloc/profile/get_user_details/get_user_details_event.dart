part of 'get_user_details_bloc.dart';

@freezed
class GetUserDetailsEvent with _$GetUserDetailsEvent {
  const factory GetUserDetailsEvent.started() = _Started;
  const factory GetUserDetailsEvent.getUserDetails() = _GetUserDetails;
}
