import 'package:bloc/bloc.dart';
import 'package:beaja_toko/datasource/profile/get_user_details/get_user_detail_datasource.dart';
import 'package:beaja_toko/models/profile/get_user_details/get_user_detail_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_details_event.dart';
part 'get_user_details_state.dart';
part 'get_user_details_bloc.freezed.dart';

class GetUserDetailsBloc
    extends Bloc<GetUserDetailsEvent, GetUserDetailsState> {
  GetUserDetailsBloc() : super(const _Initial()) {
    on<_GetUserDetails>((event, emit) async {
      final response = await GetUserDetailsDatasource().getUserDetails();
      response.fold(
        (error) => emit(_Error(error)),
        (data) {
          emit(_Loaded(data));
        },
      );
    });
  }
}
