import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/common/constants/widgets/indicator.dart';
import 'package:beaja_toko/pages/profile/widgets/button/button_confirmation_logout.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ListMenuText extends StatelessWidget {
  const ListMenuText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.centerLeft,
          child: const Text('Send Feedback'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.centerLeft,
          child: const Text('Rate us on the Play Store'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              showModalLogoutConfirmation(context);
            },
            child: Text(
              'Logout',
              style: TextStyles.regular(
                  color: AppColors.danger, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Ionicons.warning_outline),
                  Text('About'),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  void showModalLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.30,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white),
          child: Column(
            children: [
              const IndicatorModal(),
              CustomDividers.smallDivider(),
              Text(
                'Kamu yakin ingin keluar dari aplikasi ini?',
                style: TextStyles.medium(),
              ),
              CustomDividers.smallDivider(),
              const ButtonConfirmationLogout(),
            ],
          ),
        );
      },
    );
  }
}
