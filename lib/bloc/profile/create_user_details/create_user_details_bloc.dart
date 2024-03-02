import 'package:beaja_toko/datasource/profile/create_user_details/create_user_details_datasource.dart';
import 'package:beaja_toko/models/profile/create_user_details/create_user_details_request_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_user_details_event.dart';
part 'create_user_details_state.dart';
part 'create_user_details_bloc.freezed.dart';

class CreateUserDetailsBloc
    extends Bloc<CreateUserDetailsEvent, CreateUserDetailsState> {
  CreateUserDetailsBloc() : super(const _Initial()) {
    on<_CreateUserDetails>((event, emit) async {
      emit(const _Loading());
      final response = await CreateUserDetailsDatasource()
          .createUserDetails(event.requestModel, event.userId);
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
