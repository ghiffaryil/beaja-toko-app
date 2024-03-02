import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:flutter/material.dart';

class ListMenuCard extends StatefulWidget {
  const ListMenuCard({super.key});

  @override
  State<ListMenuCard> createState() => _ListMenuCardState();
}

class _ListMenuCardState extends State<ListMenuCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: CustomPadding.p1,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    'My Orders',
                    style: TextStyles.h4(color: AppColors.primary),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
              ],
            )),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: CustomPadding.p1,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    'My Favorites',
                    style: TextStyles.h4(color: AppColors.primary),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
              ],
            )),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: CustomPadding.p1,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Privacy Policy',
                    style: TextStyles.h4(color: AppColors.primary),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
              ],
            )),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: CustomPadding.p1,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Terms and Conditions',
                    style: TextStyles.h4(color: AppColors.primary),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
              ],
            )),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: CustomPadding.p1,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Help',
                    style: TextStyles.h4(color: AppColors.primary),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
              ],
            )),
      ],
    );
  }
}
