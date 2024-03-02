import 'package:beaja_toko/datasource/auth/register/register_datasource.dart';
import 'package:beaja_toko/models/auth/register/register_request_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_register_event.dart';
part 'auth_register_state.dart';
part 'auth_register_bloc.freezed.dart';

class AuthRegisterBloc extends Bloc<AuthRegisterEvent, AuthRegisterState> {
  AuthRegisterBloc() : super(const _Initial()) {
    on<_Register>((event, emit) async {
      final response = await RegisterDatasource().register(event.requestModel);
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
