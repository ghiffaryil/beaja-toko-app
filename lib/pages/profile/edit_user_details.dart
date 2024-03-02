import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/pages/profile/profile.dart';
import 'package:beaja_toko/pages/profile/widgets/form/form_input_update_user_details.dart';
import 'package:flutter/material.dart';

class EditUserDetails extends StatefulWidget {
  const EditUserDetails({super.key});

  @override
  State<EditUserDetails> createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          title: Text(
            'Edit Profile',
            style: TextStyles.h3(color: AppColors.white),
          ),
          backgroundColor: AppColors.primary,
          leading: IconButton(
              color: AppColors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ProfilePage();
                }));
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined))),
      body: Container(
        color: AppColors.white,
        width: double.infinity,
        padding: CustomPadding.p2,
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              FormInputUpdateUserDetails(),
            ],
          ),
        ),
      ),
    );
  }
}
