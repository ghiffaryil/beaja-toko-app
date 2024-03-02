import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:flutter/material.dart';

class ListMenuHorizontal extends StatelessWidget {
  const ListMenuHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: CustomPadding.p1,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Center(
                child: Icon(Icons.map_sharp),
              ),
              Text('Address', style: TextStyles.small()),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: CustomPadding.p1,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Center(
                child: Icon(Icons.credit_card),
              ),
              Text('Payment', style: TextStyles.small()),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: CustomPadding.p1,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Center(
                child: Icon(Icons.notifications),
              ),
              Text('Notifications', style: TextStyles.small()),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: CustomPadding.p1,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Center(
                child: Icon(Icons.settings),
              ),
              Text('Settings', style: TextStyles.small()),
            ],
          ),
        ),
      ],
    );
  }
}
