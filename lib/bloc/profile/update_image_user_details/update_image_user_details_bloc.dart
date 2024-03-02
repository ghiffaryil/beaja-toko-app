import 'package:beaja_toko/datasource/profile/update_user_details/update_image_user_details_datasource.dart';
import 'package:beaja_toko/models/profile/update_user_details/update_image_user_details_request_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_image_user_details_event.dart';
part 'update_image_user_details_state.dart';
part 'update_image_user_details_bloc.freezed.dart';

class UpdateImageUserDetailsBloc
    extends Bloc<UpdateImageUserDetailsEvent, UpdateImageUserDetailsState> {
  UpdateImageUserDetailsBloc() : super(const _Initial()) {
    on<_UpdateImage>((event, emit) async {
      emit(const _Loading());
      final response = await UpdateImageUserDetailsDatasource()
          .update(event.requestModel, event.userId);
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
