import 'package:beaja_toko/bloc/profile/update_user_details/update_user_details_bloc.dart';
import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:beaja_toko/common/constants/widgets/show_toast.dart';
import 'package:beaja_toko/common/components/input_field_text_underline_border.dart';
import 'package:beaja_toko/datasource/profile/get_user_details/get_user_detail_datasource.dart';
import 'package:beaja_toko/models/profile/update_user_details/update_user_details_request_model.dart';
import 'package:beaja_toko/pages/maps/map_screen.dart';
import 'package:beaja_toko/pages/profile/profile.dart';
import 'package:beaja_toko/repository/user/alamat_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class FormInputUpdateUserDetails extends StatefulWidget {
  const FormInputUpdateUserDetails({super.key});

  @override
  State<FormInputUpdateUserDetails> createState() =>
      _FormInputUpdateUserDetailsState();
}

class _FormInputUpdateUserDetailsState
    extends State<FormInputUpdateUserDetails> {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputNamaDepan = TextEditingController();
  TextEditingController inputNamaTengah = TextEditingController();
  TextEditingController inputNamaBelakang = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
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
  FocusNode inputPhoneFocus = FocusNode();
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

  // POSITION
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;

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
          print("Location permissions are permanently denied");
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
    setState(() {
      inputLatitude.text = position.longitude.toString();
      inputLongitude.text = position.latitude.toString();
    });
  }

  void getAlamatUserRepository() async {
    final getAlamatUser = await AlamatUserReporitory().getAlamatUser();
    print('getAlamatUser');
    print(getAlamatUser);
    if (getAlamatUser.isNotEmpty) {
      print('Lat Long dari Repository');
      setState(() {
        inputLatitude.text = getAlamatUser['lat_user'];
        inputLongitude.text = getAlamatUser['long_user'];
      });
    }
  }

  void updateAlamatUser() async {
    final getAlamatUser = await AlamatUserReporitory().getAlamatUser();
    if (getAlamatUser.isNotEmpty) {
      setState(() {
        inputAlamatLengkap.text = getAlamatUser['alamat_user'];
        inputDesa.text = getAlamatUser['kelurahan_user'];
        inputKecamatan.text = getAlamatUser['kecamatan_user'];
        inputProvinsi.text = getAlamatUser['provinsi_user'];
        inputLatitude.text = getAlamatUser['lat_user'];
        inputLongitude.text = getAlamatUser['long_user'];
      });
    }
  }

  void loadGetUserDetails() async {
    try {
      final result = await GetUserDetailsDatasource().getUserDetails();
      result.fold(
        (error) {},
        (data) {
          final user = data;
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
            inputNib.text = userDetails.nib;
            inputNamaToko.text = userDetails.namaToko;
            userImage = userDetails.image;
          });
        },
      );
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextInputFieldUnderline(
          focusNode: inputNamaTokoFocus,
          keyboardType: TextInputType.text,
          controller: inputNamaToko,
          hintText: 'Nama Toko*',
          labelText: 'Nama Toko*',
          editable: false,
        ),
        TextInputFieldUnderline(
          focusNode: inputNibFocus,
          keyboardType: TextInputType.text,
          controller: inputNib,
          hintText: 'NIB*',
          labelText: 'NIB*',
          editable: false,
        ),
        TextInputFieldUnderline(
          focusNode: inputNamaDepanFocus,
          keyboardType: TextInputType.text,
          controller: inputNamaDepan,
          hintText: 'Nama Depan*',
          labelText: 'Nama Depan*',
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputNamaTengahFocus,
          keyboardType: TextInputType.text,
          controller: inputNamaTengah,
          hintText: 'Nama Tengah',
          labelText: 'Nama Tengah',
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputNamaBelakangFocus,
          keyboardType: TextInputType.text,
          controller: inputNamaBelakang,
          hintText: 'Nama Belakang',
          labelText: 'Nama Belakang',
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          keyboardType: TextInputType.emailAddress,
          controller: inputEmail,
          hintText: 'Email',
          labelText: 'Email',
          editable: false,
        ),
        CustomDividers.verySmallDivider(),
        TextInputFieldUnderline(
          focusNode: inputPhoneFocus,
          keyboardType: TextInputType.phone,
          controller: inputPhone,
          hintText: 'Nomor Telepon*',
          labelText: 'Nomor Telepon*',
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
                    onPressed: () async {
                      inputLatitude.text = '';
                      inputLongitude.text = '';
                      // getLocation();

                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const MapScreen();
                          },
                        ),
                      );

                      updateAlamatUser();
                    },
                    icon: const Icon(
                      Icons.map_rounded,
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
        CustomDividers.regularDivider(),
        updateUserDetailsButton(),
        CustomDividers.verySmallDivider(),
      ],
    );
  }

  Widget updateUserDetailsButton() {
    return BlocListener<UpdateUserDetailsBloc, UpdateUserDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loaded: (data) {
            showToast(message: data);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const ProfilePage();
            }));
          },
        );
      },
      child: BlocBuilder<UpdateUserDetailsBloc, UpdateUserDetailsState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return ButtonFilled.primary(
                text: 'UPDATE',
                onPressed: () {
                  final requestModel = UpdateUserDetailsRequestModel(
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
                    nib: inputNib.text,
                    namaToko: inputNamaToko.text,
                    noHp: inputNomorHandphone.text,
                  );

                  if (requestModel.namaDepan.isEmpty ||
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
                    context.read<UpdateUserDetailsBloc>().add(
                          UpdateUserDetailsEvent.update(
                            requestModel,
                            userId,
                          ),
                        );
                  }
                },
              );
            },
            loading: () {
              return ButtonFilled.primary(
                text: '',
                onPressed: () {},
                loading: true,
              );
            },
          );
        },
      ),
    );
  }
}
