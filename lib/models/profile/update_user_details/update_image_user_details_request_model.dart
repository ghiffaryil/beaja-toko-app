import 'package:image_picker/image_picker.dart';

class UpdateImageUserDetailsRequestModel {
  final XFile? image;

  UpdateImageUserDetailsRequestModel({
    required this.image,
  });

  Map<String, String> toFormData() {
    final Map<String, String> formData = {
      'image': image!.path,
    };

    return formData;
  }
}
