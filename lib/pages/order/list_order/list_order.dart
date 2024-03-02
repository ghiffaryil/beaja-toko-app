import 'package:beaja_toko/common/constants/navigation/navigation_bottom_bar.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:flutter/material.dart';

class ListOrderPage extends StatefulWidget {
  const ListOrderPage({super.key});

  @override
  State<ListOrderPage> createState() => _ListOrderPageState();
}

class _ListOrderPageState extends State<ListOrderPage> {
  String _selectedFilter = 'Semua'; // Initial selected filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: const Text('List Order'),
      ),
      body: Column(
        children: [
          _buildFilterHorizontalView(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemCount: 10, // Replace with your actual item count
                itemBuilder: (context, index) {
                  // Replace Placeholder with your order item widget
                  return _buildOrderCard(index);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomMenu(
        selectedIndex: 2,
      ),
    );
  }

  Widget _buildFilterHorizontalView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          _buildFilterItem('Semua'),
          _buildFilterItem('Belum diproses'),
          _buildFilterItem('Sedang diproses'),
          _buildFilterItem('Sedang dikirim'),
          _buildFilterItem('Selesai'),
        ],
      ),
    );
  }

  Widget _buildFilterItem(String filter) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filter;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: _selectedFilter == filter ? AppColors.secondary : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _selectedFilter == filter
                ? AppColors.secondary
                : AppColors.primary,
            width: 1,
          ),
        ),
        child: Text(
          filter,
          style: TextStyle(
            color:
                _selectedFilter == filter ? AppColors.white : AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(int index) {
    return Container(
      padding: CustomPadding.p1,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Nomor Order: ${index + 1}'),
            Text(
              '2024-03-02 10:00',
              style: TextStyles.small(color: AppColors.muted),
            ),
          ],
        ),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pemesan: Customer Name'),
            Text('Harga: \$100'),
            Text('Diskon: 10%'),
            Text('Promo: Promo Name'),
          ],
        ),
      ),
    );
  }
}
