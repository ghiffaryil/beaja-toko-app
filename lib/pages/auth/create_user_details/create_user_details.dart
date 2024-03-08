import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/common/functions/get_permission_location/get_permission_location.dart';
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

  void checkGpsPermission() {
    getPermissionLocation(context);
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
