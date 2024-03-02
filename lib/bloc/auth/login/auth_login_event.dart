part of 'auth_login_bloc.dart';

@freezed
class AuthLoginEvent with _$AuthLoginEvent {
  const factory AuthLoginEvent.started() = _Started;
  const factory AuthLoginEvent.login(LoginRequestModel requestModel) = _Login;
}
