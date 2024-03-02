part of 'update_image_user_details_bloc.dart';

@freezed
class UpdateImageUserDetailsEvent with _$UpdateImageUserDetailsEvent {
  const factory UpdateImageUserDetailsEvent.started() = _Started;
  const factory UpdateImageUserDetailsEvent.updateImage(
          UpdateImageUserDetailsRequestModel requestModel, int userId) =
      _UpdateImage;
}
