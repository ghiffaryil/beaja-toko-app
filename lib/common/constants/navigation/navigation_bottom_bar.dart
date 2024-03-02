import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/pages/homepage/homepage.dart';
import 'package:beaja_toko/pages/order/list_order/list_order.dart';
import 'package:beaja_toko/pages/product/list_product/list_product.dart';
import 'package:beaja_toko/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class BottomMenu extends StatefulWidget {
  final int selectedIndex;
  const BottomMenu({super.key, this.selectedIndex = 0});
  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  void initState() {
    super.initState();
  }

  void onClicked(int index) {
    if (widget.selectedIndex == index) {
      return;
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (BuildContext context) {
        return pageTarget[index];
      }));
    }
  }

  final List<Widget> pageTarget = [
    const HomePage(),
    const ListProductPage(),
    const ListOrderPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: widget.selectedIndex == 0
                ? const Icon(
                    Ionicons.home,
                    color: AppColors.primary,
                    size: 28,
                  )
                : const Icon(
                    Ionicons.home_outline,
                    color: AppColors.primary,
                    size: 28,
                  ),
            label: 'Label',
          ),
          BottomNavigationBarItem(
            icon: widget.selectedIndex == 1
                ? const Icon(
                    Ionicons.fast_food,
                    color: AppColors.primary,
                    size: 28,
                  )
                : const Icon(
                    Ionicons.fast_food_outline,
                    color: AppColors.primary,
                    size: 28,
                  ),
            label: 'Label',
          ),
          BottomNavigationBarItem(
            icon: widget.selectedIndex == 2
                ? const Icon(
                    Ionicons.bag_handle,
                    color: AppColors.primary,
                    size: 28,
                  )
                : const Icon(
                    Ionicons.bag_outline,
                    color: AppColors.primary,
                    size: 28,
                  ),
            label: 'Label',
          ),
          BottomNavigationBarItem(
            icon: widget.selectedIndex == 3
                ? const Icon(
                    Ionicons.person_circle,
                    color: AppColors.primary,
                    size: 28,
                  )
                : const Icon(
                    Ionicons.person_circle_outline,
                    color: AppColors.primary,
                    size: 28,
                  ),
            label: 'Label',
          ),
        ],
        currentIndex: widget.selectedIndex,
        onTap: onClicked,
        selectedItemColor: AppColors.primary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
