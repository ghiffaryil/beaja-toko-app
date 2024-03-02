import 'package:beaja_toko/datasource/auth/login/login_datasource.dart';
import 'package:beaja_toko/models/auth/login/login_request_model.dart';
import 'package:beaja_toko/models/auth/login/login_response_model.dart';
import 'package:beaja_toko/repository/auth/auth_local_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_event.dart';
part 'auth_login_state.dart';
part 'auth_login_bloc.freezed.dart';

class AuthLoginBloc extends Bloc<AuthLoginEvent, AuthLoginState> {
  AuthLoginBloc() : super(_Initial()) {
    on<_Login>((event, emit) async {
      final response = await LoginDatasource().login(event.requestModel);
      response.fold(
        (error) => emit(_Error(error)),
        (data) {
          // Save user data to Local Storage
          AuthLocalRepository().saveAuthData(data);
          emit(_Loaded(data));
        },
      );
    });
  }
}
