// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:async';
import 'package:beaja_toko/bloc/profile/create_user_details/create_user_details_bloc.dart';
import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/images.dart';
import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:beaja_toko/common/constants/function/show_toast.dart';
import 'package:beaja_toko/common/components/input_field_text_underline_border.dart';
import 'package:beaja_toko/datasource/profile/get_user_details/get_user_detail_datasource.dart';
import 'package:beaja_toko/models/profile/create_user_details/create_user_details_request_model.dart';
import 'package:beaja_toko/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ionicons/ionicons.dart';

class FormInputCreateUserDetails extends StatefulWidget {
  const FormInputCreateUserDetails({super.key});

  @override
  State<FormInputCreateUserDetails> createState() =>
      _FormInputCreateUserDetailsState();
}

class _FormInputCreateUserDetailsState
    extends State<FormInputCreateUserDetails> {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputNamaDepan = TextEditingController();
  TextEditingController inputNamaTengah = TextEditingController();
  TextEditingController inputNamaBelakang = TextEditingController();
  TextEditingController inputNomorHandphone = TextEditingController();
  TextEditingController inputAlamatLengkap = TextEditingController();
  TextEditingController inputProvinsi = TextEditingController();
  TextEditingController inputKecamatan = TextEditingController();
  TextEditingController inputDesa = TextEditingController();
  TextEditingController inputRT = TextEditingController();
  TextEditingController inputRW = TextEditingController();
  TextEditingController inputNomorRumah = TextEditingController();
  TextEditingController inputKodePos = TextEditingController();
  TextEditingController inputLatitude = TextEditingController();
  TextEditingController inputLongitude = TextEditingController();
  TextEditingController inputNik = TextEditingController();
  TextEditingController inputNib = TextEditingController();
  TextEditingController inputNamaToko = TextEditingController();

  FocusNode inputNamaDepanFocus = FocusNode();
  FocusNode inputNamaTengahFocus = FocusNode();
  FocusNode inputNamaBelakangFocus = FocusNode();
  FocusNode inputNomorHandphoneFocus = FocusNode();
  FocusNode inputAlamatLengkapFocus = FocusNode();
  FocusNode inputProvinsiFocus = FocusNode();
  FocusNode inputKecamatanFocus = FocusNode();
  FocusNode inputDesaFocus = FocusNode();
  FocusNode inputRTFocus = FocusNode();
  FocusNode inputRWFocus = FocusNode();
  FocusNode inputNomorRumahFocus = FocusNode();
  FocusNode inputKodePosFocus = FocusNode();
  FocusNode inputLatitudeFocus = FocusNode();
  FocusNode inputLongitudeFocus = FocusNode();
  FocusNode inputNikFocus = FocusNode();
  FocusNode inputNibFocus = FocusNode();
  FocusNode inputNamaTokoFocus = FocusNode();

  XFile? profileImage;
  String profileImageSelected = '';
  final ImagePicker picker = ImagePicker();

  // POSITION
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  int userId = 0;
  bool isHaveUserDetails = false;
  String userImage = '';
  @override
  void initState() {
    super.initState();
    loadGetUserDetails();
    checkGpsPermission();
  }

  void checkGpsPermission() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
      inputLatitude.text = lat;
      inputLongitude.text = long;
    });
  }

  void loadGetUserDetails() async {
    try {
      final result = await GetUserDetailsDatasource().getUserDetails();
      result.fold(
        (error) {},
        (data) {
          final user = data;
          if (user.userDetail.isEmpty) {
            setState(() {
              isHaveUserDetails = false;
              userId = user.id;
              inputEmail.text = data.email;
            });
          } else {
            final userDetails = user.userDetail.first;
            setState(() {
              inputEmail.text = data.email;
              userId = userDetails.id;
              isHaveUserDetails = true;
              inputNamaDepan.text = userDetails.namaDepan;
              inputNamaTengah.text = userDetails.namaTengah;
              inputNamaBelakang.text = userDetails.namaBelakang;
              inputNomorHandphone.text = userDetails.phone;
              inputAlamatLengkap.text = userDetails.alamatLengkap;
              inputProvinsi.text = userDetails.provinsi;
              inputKecamatan.text = userDetails.kecamatan;
              inputDesa.text = userDetails.desa;
              inputRT.text = userDetails.rt;
              inputRW.text = userDetails.rw;
              inputNomorRumah.text = userDetails.noRumah;
              inputKodePos.text = userDetails.kodePos;
              inputLatitude.text = userDetails.lat;
              inputLongitude.text = userDetails.long;
              inputNik.text = userDetails.nik;
              userImage = userDetails.image;
            });
          }
          // print('userId $userId');
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDividers.verySmallDivider(),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: profileImageSelected != ''
                          ? Image.file(File(profileImage!.path),
                              fit: BoxFit.contain)
                          : userImage == ''
                              ? Image.asset(Images.userEmpty,
                                  fit: BoxFit.contain)
                              : Image.network(
                                  userImage,
                                  fit: BoxFit.cover,
                                ),
                    )),
                ButtonFilled.primary(
                    iconData: Icons.file_upload_outlined,
                    backgroundColor: profileImageSelected == ''
                        ? AppColors.white
                        : AppColors.secondary,
                    textColor: profileImageSelected == ''
                        ? AppColors.secondary
                        : AppColors.white,
                    text: 'Upload',
                    minWidth: 30,
                    height: 30,
                    onPressed: () {
                      _selectImageFromGallery();
                    }),
                // Text(profileImageSelected)
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextInputFieldUnderline(
                  focusNode: inputNamaDepanFocus,
                  keyboardType: TextInputType.text,
                  controller: inputNamaDepan,
                  hintText: 'Nama Depan*',
                  labelText: 'Nama Depan*',
                ),
                TextInputFieldUnderline(
                  focusNode: inputNamaTengahFocus,
                  keyboardType: TextInputType.text,
                  controller: inputNamaTengah,
                  hintText: 'Nama Tengah',
                  labelText: 'Nama Tengah',
                ),
                TextInputFieldUnderline(
                  focusNode: inputNamaBelakangFocus,
                  keyboardType: TextInputType.text,
                  controller: inputNamaBelakang,
                  hintText: 'Nama Belakang',
                  labelText: 'Nama Belakang',
                ),
              ],
            ),
          )
        ]),
        TextInputFieldUnderline(
          keyboardType: TextInputType.emailAddress,
          controller: inputEmail,
          hintText: 'Email',
          labelText: 'Email',
          editable: false,
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputNomorHandphoneFocus,
          keyboardType: TextInputType.phone,
          controller: inputNomorHandphone,
          hintText: 'Nomor Handphone*',
          labelText: 'Nomor Handphone*',
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputAlamatLengkapFocus,
          keyboardType: TextInputType.text,
          controller: inputAlamatLengkap,
          hintText: 'Alamat Lengkap*',
          labelText: 'Alamat Lengkap*',
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputDesaFocus,
          keyboardType: TextInputType.text,
          controller: inputDesa,
          hintText: 'Desa*',
          labelText: 'Desa*',
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputKecamatanFocus,
          keyboardType: TextInputType.text,
          controller: inputKecamatan,
          hintText: 'Kecamatan*',
          labelText: 'Kecamatan*',
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputProvinsiFocus,
          keyboardType: TextInputType.text,
          controller: inputProvinsi,
          hintText: 'Provinsi*',
          labelText: 'Provinsi*',
        ),
        CustomDividers.verySmallDivider(),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextInputFieldUnderline(
                focusNode: inputRTFocus,
                keyboardType: TextInputType.number,
                controller: inputRT,
                hintText: 'RT*',
                labelText: 'RT*',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 3,
              child: TextInputFieldUnderline(
                focusNode: inputRWFocus,
                keyboardType: TextInputType.number,
                controller: inputRW,
                hintText: 'RW',
                labelText: 'RW',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 4,
              child: TextInputFieldUnderline(
                focusNode: inputNomorRumahFocus,
                keyboardType: TextInputType.text,
                controller: inputNomorRumah,
                hintText: 'No. Rumah',
                labelText: 'No. Rumah',
              ),
            ),
          ],
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputKodePosFocus,
          keyboardType: TextInputType.number,
          controller: inputKodePos,
          hintText: 'Kode Pos*',
          labelText: 'Kode Pos*',
        ),
        CustomDividers.verySmallDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 4,
              child: TextInputFieldUnderline(
                focusNode: inputLatitudeFocus,
                keyboardType: TextInputType.text,
                controller: inputLatitude,
                hintText: 'Latitude*',
                labelText: 'Latitude*',
                editable: false,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 4,
              child: TextInputFieldUnderline(
                focusNode: inputLongitudeFocus,
                keyboardType: TextInputType.text,
                controller: inputLongitude,
                hintText: 'Longitude*',
                labelText: 'Longitude*',
                editable: false,
              ),
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {
                      inputLatitude.text = '';
                      inputLongitude.text = '';
                      getLocation();
                    },
                    icon: const Icon(
                      Ionicons.location_sharp,
                      color: AppColors.primary,
                      size: 40,
                    )))
          ],
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputNikFocus,
          keyboardType: TextInputType.number,
          controller: inputNik,
          hintText: 'NIK*',
          labelText: 'NIK*',
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputNamaTokoFocus,
          keyboardType: TextInputType.number,
          controller: inputNamaToko,
          hintText: 'Nama Toko*',
          labelText: 'Nama Toko*',
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputNibFocus,
          keyboardType: TextInputType.number,
          controller: inputNib,
          hintText: 'NIB*',
          labelText: 'NIB*',
        ),
        CustomDividers.regularDivider(),
        createUserDetailsButton(),
        CustomDividers.verySmallDivider(),
      ],
    );
  }

  Widget createUserDetailsButton() {
    return BlocListener<CreateUserDetailsBloc, CreateUserDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            showToast(message: message);
          },
          loaded: (data) {
            showToast(message: data);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const HomePage();
            }));
          },
        );
      },
      child: BlocBuilder<CreateUserDetailsBloc, CreateUserDetailsState>(
        builder: (context, state) {
          return state.maybeWhen(orElse: () {
            return ButtonFilled.primary(
                text: 'CREATE',
                onPressed: () {
                  final requestModel = CreateUserDetailsRequestModel(
                    userId: userId.toString(),
                    statusPhone: 'false',
                    namaDepan: inputNamaDepan.text,
                    namaTengah: inputNamaTengah.text,
                    namaBelakang: inputNamaBelakang.text,
                    phone: inputNomorHandphone.text,
                    alamatLengkap: inputAlamatLengkap.text,
                    provinsi: inputProvinsi.text,
                    kecamatan: inputKecamatan.text,
                    desa: inputDesa.text,
                    rt: inputRT.text,
                    rw: inputRW.text,
                    noRumah: inputNomorRumah.text,
                    kodePos: inputKodePos.text,
                    lat: inputLatitude.text,
                    long: inputLongitude.text,
                    nik: inputNik.text,
                    namaToko: inputNamaToko.text,
                    nib: inputNib.text,
                    image: profileImage,
                  );

                  if (requestModel.image == null ||
                      requestModel.namaDepan.isEmpty ||
                      requestModel.alamatLengkap.isEmpty ||
                      requestModel.phone.isEmpty ||
                      requestModel.alamatLengkap.isEmpty ||
                      requestModel.provinsi.isEmpty ||
                      requestModel.kecamatan.isEmpty ||
                      requestModel.desa.isEmpty ||
                      requestModel.rt.isEmpty ||
                      requestModel.lat.isEmpty ||
                      requestModel.long.isEmpty ||
                      requestModel.kodePos.isEmpty ||
                      requestModel.nik.isEmpty ||
                      requestModel.nib.isEmpty ||
                      requestModel.namaToko.isEmpty) {
                    showToast(message: 'Lengkapi Form yang wajib diisi!');
                  } else {
                    context.read<CreateUserDetailsBloc>().add(
                          CreateUserDetailsEvent.createUserDetails(
                            requestModel,
                            userId,
                          ),
                        );
                  }
                });
          }, loading: () {
            return ButtonFilled.primary(
              backgroundColor: AppColors.primary,
              text: '',
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
        profileImage = pickedImage;
        profileImageSelected = pickedImage.name.toString();
      });
    }
  }
}
