import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NavbarTitle extends StatelessWidget {
  final String namaToko;
  final String alamatToko;

  const NavbarTitle({
    super.key,
    required this.namaToko,
    required this.alamatToko,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, $namaToko',
          style: TextStyles.large(color: AppColors.primary),
        ),
        Row(
          children: [
            const Icon(
              Ionicons.location_outline,
              color: AppColors.secondary,
              size: 15,
            ),
            Text(
              '  $alamatToko',
              style: TextStyles.small(),
            ),
          ],
        )
      ],
    );
  }
}
