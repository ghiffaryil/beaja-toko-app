part of 'auth_register_bloc.dart';

@freezed
class AuthRegisterEvent with _$AuthRegisterEvent {
  const factory AuthRegisterEvent.started() = _Started;
  const factory AuthRegisterEvent.register(RegisterRequestModel requestModel) =
      _Register;
}
