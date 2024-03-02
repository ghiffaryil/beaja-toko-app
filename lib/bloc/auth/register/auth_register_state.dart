part of 'auth_register_bloc.dart';

@freezed
class AuthRegisterState with _$AuthRegisterState {
  const factory AuthRegisterState.initial() = _Initial;
  const factory AuthRegisterState.loading() = _Loading;
  const factory AuthRegisterState.loaded(String data) = _Loaded;
  const factory AuthRegisterState.error(String message) = _Error;
}
