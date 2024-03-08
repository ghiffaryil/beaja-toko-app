// ignore_for_file: avoid_print

import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/constants/navigation/navigation_bottom_bar.dart';

import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/datasource/profile/get_user_details/get_user_detail_datasource.dart';
import 'package:beaja_toko/pages/auth/create_user_details/create_user_details.dart';
import 'package:beaja_toko/pages/profile/edit_user_details.dart';
import 'package:beaja_toko/pages/profile/widgets/list/list_menu_text.dart';
import 'package:beaja_toko/pages/profile/widgets/list/list_menu_card.dart';
import 'package:beaja_toko/pages/profile/widgets/list/list_menu_horizontal.dart';
import 'package:beaja_toko/pages/profile/widgets/card/user_information_card.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isHaveUserDetails = false;
  int selectedIndex = 3;
  int userId = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = 3;
    loadGetUserDetails();
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
              userId = data.id;
            });
          } else {
            setState(() {
              isHaveUserDetails = true;
              userId = data.userDetail.first.id;
            });
          }
          print(isHaveUserDetails.toString());
          print('userId => $userId');
        },
      );
    } catch (e) {
      // print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgprofile,
        surfaceTintColor: AppColors.bgprofile,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.bgprofile,
          padding: CustomPadding.pdefault,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Personal Details',
                    style: TextStyles.h4(),
                  ),
                  GestureDetector(
                      child: Text(
                        'Edit',
                        style: TextStyles.h4(color: AppColors.primary),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => isHaveUserDetails
                                    ? const EditUserDetails()
                                    : const CreateUserDetails())));
                      }),
                ],
              ),
              CustomDividers.smallDivider(),
              UserInformationCard(userId: userId),
              CustomDividers.smallDivider(),
              const ListMenuHorizontal(),
              CustomDividers.smallDivider(),
              const ListMenuCard(),
              CustomDividers.smallDivider(),
              const ListMenuText(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
    );
  }
}
