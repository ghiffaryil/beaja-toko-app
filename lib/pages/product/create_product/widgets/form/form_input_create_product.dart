// ignore_for_file: avoid_print

import 'dart:io';
import 'package:beaja_toko/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:beaja_toko/bloc/product/create_item/create_item_bloc.dart';
import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:beaja_toko/common/constants/widgets/show_toast.dart';
import 'package:beaja_toko/common/components/input_field_text_underline_border.dart';
import 'package:beaja_toko/common/constants/styles/images.dart';
import 'package:beaja_toko/models/product/create_item/create_item_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class FormInputCreateProduct extends StatefulWidget {
  final int userId;

  const FormInputCreateProduct({super.key, required this.userId});

  @override
  State<FormInputCreateProduct> createState() => _FormInputCreateProductState();
}

class _FormInputCreateProductState extends State<FormInputCreateProduct> {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputNamaItem = TextEditingController();
  TextEditingController inputJenisItem = TextEditingController();
  TextEditingController inputVolume = TextEditingController();
  TextEditingController inputHarga = TextEditingController();

  FocusNode inputNamaItemFocus = FocusNode();
  FocusNode inputJenisItemFocus = FocusNode();
  FocusNode inputVolumeFocus = FocusNode();
  FocusNode inputHargaFocus = FocusNode();

  XFile? productImage;
  String productImageSelected = '';
  final ImagePicker picker = ImagePicker();
  String userImage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            _selectImageFromGallery();
          },
          child: Container(
            child: productImage != null
                ? Image.file(
                    File(productImage!.path),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  )
                : Image.asset(
                    Images.imageEmpty,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),
          ),
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputNamaItemFocus,
          keyboardType: TextInputType.text,
          controller: inputNamaItem,
          hintText: 'Nama Item*',
          labelText: 'Nama Item*',
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputJenisItemFocus,
          keyboardType: TextInputType.text,
          controller: inputJenisItem,
          hintText: 'Jenis Item*',
          labelText: 'Jenis Item*',
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputVolumeFocus,
          keyboardType: TextInputType.text,
          controller: inputVolume,
          hintText: 'Volume',
          labelText: 'Volume',
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputHargaFocus,
          keyboardType: TextInputType.phone,
          controller: inputHarga,
          hintText: 'Harga*',
          labelText: 'Harga*',
        ),
        CustomDividers.verySmallDivider(),
        CustomDividers.regularDivider(),
        createProductSubmitButton(),
        CustomDividers.verySmallDivider(),
      ],
    );
  }

  Widget createProductSubmitButton() {
    return BlocListener<CreateItemBloc, CreateItemState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            showToast(message: message);
          },
          loading: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                    surfaceTintColor: AppColors.white,
                    content: SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    ));
              },
              barrierDismissible: false,
            );
          },
          loaded: (data) {
            showToast(message: 'Item Created');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const HomePage();
            }));
          },
        );
      },
      child: BlocBuilder<CreateItemBloc, CreateItemState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return ButtonFilled.primary(
                text: 'Simpan',
                onPressed: () {
                  final requestModel = CreateItemRequestModel(
                    userId: widget.userId.toString(),
                    namaItem: inputNamaItem.text,
                    jenisItem: inputJenisItem.text,
                    volume: inputVolume.text,
                    harga: inputHarga.text,
                    image: productImage,
                  );

                  if (requestModel.image == null ||
                      requestModel.namaItem.isEmpty ||
                      requestModel.jenisItem.isEmpty ||
                      requestModel.harga.isEmpty) {
                    showToast(message: 'Lengkapi Form yang wajib diisi!');
                  } else {
                    context.read<CreateItemBloc>().add(
                          CreateItemEvent.createItem(
                            requestModel,
                          ),
                        );
                  }
                });
          }, loading: () {
            return ButtonFilled.primary(
              backgroundColor: AppColors.primary,
              text: '',
              textColor: AppColors.white,
              onPressed: () {},
              loading: true,
            );
          });
        },
      ),
    );
  }

  void _selectImageFromGallery() async {
    print('Pick Image');
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        print('Image Selected = ${pickedImage.path}');
        productImage = pickedImage;
        productImageSelected = pickedImage.name.toString();
      });
    }
  }
}
