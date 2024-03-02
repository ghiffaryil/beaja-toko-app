import 'package:beaja_toko/datasource/auth/verify_otp/verify_otp_datasource.dart';
import 'package:beaja_toko/models/auth/verify_otp/verify_otp_request_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';
part 'verify_otp_bloc.freezed.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(const _Initial()) {
    on<_VerifyOtp>((event, emit) async {
      final response =
          await VerifyOtpDatasource().verifyOtp(event.requestModel);
      response.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
