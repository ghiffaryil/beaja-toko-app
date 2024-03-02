import 'package:beaja_toko/common/constants/function/show_toast.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/pages/auth/create_user_details/widgets/form_input_create_user_details.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CreateUserDetails extends StatefulWidget {
  const CreateUserDetails({super.key});

  @override
  State<CreateUserDetails> createState() => _CreateUserDetailsState();
}

class _CreateUserDetailsState extends State<CreateUserDetails> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;

  @override
  void initState() {
    super.initState();
    checkGpsPermission();
  }

  void checkGpsPermission() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showToast(message: 'Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          showToast(message: "Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
    } else {
      showToast(message: 'GPS Service is not enabled, turn on GPS location');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          'Lengkapi Profile',
          style: TextStyles.h3(color: AppColors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
      ),
      body: Container(
        color: AppColors.white,
        width: double.infinity,
        padding: CustomPadding.p2,
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              FormInputCreateUserDetails(),
            ],
          ),
        ),
      ),
    );
  }
}
