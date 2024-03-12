// ignore_for_file: avoid_print

import 'dart:io';
import 'package:beaja_toko/common/constants/styles/styles.dart';
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
import 'package:flutter/widgets.dart';
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
  TextEditingController inputHarga = TextEditingController();

  FocusNode inputNamaItemFocus = FocusNode();
  FocusNode inputHargaFocus = FocusNode();

  String jenisItem = 'makanan';
  String volumeItem = '';

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
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: productImage != null
              ? Stack(
                  children: [
                    Image.file(
                      File(productImage!.path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          _selectImageFromGallery();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            color: Colors.black.withOpacity(0.8),
                            child: const Icon(
                              Icons.file_upload_outlined,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: () {
                    _selectImageFromGallery();
                  },
                  child: Image.asset(
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
        CustomDividers.smallDivider(),
        Container(
            alignment: Alignment.centerLeft, child: const Text('Jenis Item')),
        CustomDividers.verySmallDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  jenisItem = "makanan";
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: jenisItem == "makanan"
                        ? AppColors.secondary
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1,
                        color: jenisItem == "makanan"
                            ? AppColors.secondary
                            : AppColors.light)),
                child: Text('Makanan',
                    style: TextStyles.h6(
                        color: jenisItem == "makanan"
                            ? AppColors.white
                            : AppColors.secondary)),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  jenisItem = "minuman";
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: jenisItem == "minuman"
                        ? AppColors.secondary
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1,
                        color: jenisItem == "minuman"
                            ? AppColors.secondary
                            : AppColors.light)),
                child: Text('Minuman',
                    style: TextStyles.h6(
                        color: jenisItem == "minuman"
                            ? AppColors.white
                            : AppColors.secondary)),
              ),
            ),
          ],
        ),
        jenisItem == "minuman"
            ? Column(
                children: [
                  CustomDividers.smallDivider(),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: const Text('Volume')),
                  CustomDividers.verySmallDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            volumeItem = "kecil";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: volumeItem == "kecil"
                                  ? AppColors.secondary
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 1,
                                  color: volumeItem == "kecil"
                                      ? AppColors.secondary
                                      : AppColors.light)),
                          child: Text('Kecil',
                              style: TextStyles.h6(
                                  color: volumeItem == "kecil"
                                      ? AppColors.white
                                      : AppColors.secondary)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            volumeItem = "sedang";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: volumeItem == "sedang"
                                  ? AppColors.secondary
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 1,
                                  color: volumeItem == "sedang"
                                      ? AppColors.secondary
                                      : AppColors.light)),
                          child: Text('Sedang',
                              style: TextStyles.h6(
                                  color: volumeItem == "sedang"
                                      ? AppColors.white
                                      : AppColors.secondary)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            volumeItem = "besar";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: volumeItem == "besar"
                                  ? AppColors.secondary
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 1,
                                  color: volumeItem == "besar"
                                      ? AppColors.secondary
                                      : AppColors.light)),
                          child: Text('Besar',
                              style: TextStyles.h6(
                                  color: volumeItem == "besar"
                                      ? AppColors.white
                                      : AppColors.secondary)),
                        ),
                      ),
                    ],
                  ),
                  CustomDividers.verySmallDivider(),
                ],
              )
            : CustomDividers.verySmallDivider(),
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
    return BlocProvider(
      create: (context) => CreateItemBloc(),
      child: BlocListener<CreateItemBloc, CreateItemState>(
        listener: (context, state) {
          print(state);
          state.maybeWhen(
            orElse: () {
              return showDialog(
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
            error: (message) {
              showToast(message: message);
            },
            loading: () {},
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
                      jenisItem: jenisItem,
                      volume: volumeItem,
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
              return const CircularProgressIndicator(
                color: AppColors.secondary,
              );
            });
          },
        ),
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
