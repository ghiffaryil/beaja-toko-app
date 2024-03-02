import 'package:beaja_toko/datasource/product/get_item/get_item_datasource.dart';
import 'package:beaja_toko/models/product/get_item/get_item_request_model.dart';
import 'package:beaja_toko/models/product/get_item/get_item_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_item_event.dart';
part 'get_item_state.dart';
part 'get_item_bloc.freezed.dart';

class GetItemBloc extends Bloc<GetItemEvent, GetItemState> {
  GetItemBloc() : super(const _Initial()) {
    on<_GetItem>((event, emit) async {
      final response = await GetItemDatasource().getItem(event.requestModel);
      response.fold(
        (error) => emit(_Error(error)),
        (data) {
          emit(_Loaded(data));
        },
      );
    });
  }
}
