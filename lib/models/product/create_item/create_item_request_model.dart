import 'package:image_picker/image_picker.dart';

class CreateItemRequestModel {
  final String userId;
  final String namaItem;
  final String jenisItem;
  final String volume;
  final String harga;
  final XFile? image;

  CreateItemRequestModel({
    required this.userId,
    required this.namaItem,
    required this.jenisItem,
    required this.volume,
    required this.harga,
    required this.image,
  });

  Map<String, String> toFormData() {
    final Map<String, String> formData = {
      'user_id': userId.toString(),
      'nama_item': namaItem,
      'jenis_item': jenisItem,
      'volume': volume,
      'harga': harga,
      'image': image!.path
    };

    // // If image is not null, add it to formData as a string representation
    // if (image != null) {
    //   formData['image'] = image!.path; // Assuming image is a file path
    //   // print(formData);
    // }

    return formData;
  }
}
