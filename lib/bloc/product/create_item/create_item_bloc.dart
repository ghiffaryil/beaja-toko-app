import 'package:beaja_toko/datasource/product/create_item/create_item_datasource.dart';
import 'package:beaja_toko/models/product/create_item/create_item_request_model.dart';
import 'package:beaja_toko/models/product/create_item/create_item_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_item_event.dart';
part 'create_item_state.dart';
part 'create_item_bloc.freezed.dart';

class CreateItemBloc extends Bloc<CreateItemEvent, CreateItemState> {
  CreateItemBloc() : super(const _Initial()) {
    on<_CreateItem>((event, emit) async {
      final response =
          await CreateItemDatasource().createItem(event.requestModel);
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
