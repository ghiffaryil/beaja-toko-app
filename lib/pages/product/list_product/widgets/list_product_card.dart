import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/common/extension/helper/currency_helper.dart';
import 'package:beaja_toko/models/product/get_item/get_item_response_model.dart';
import 'package:flutter/material.dart';

class ListProductCard extends StatefulWidget {
  final ListItem dataProduct;
  const ListProductCard({
    super.key,
    required this.dataProduct,
  });

  @override
  State<ListProductCard> createState() => _ListProductCardState();
}

class _ListProductCardState extends State<ListProductCard> {
  @override
  Widget build(BuildContext context) {
    final product = widget.dataProduct;
    return Container(
      padding: const EdgeInsets.all(10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                height: 160,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(7.0),
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.010,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDividers.verySmallDivider(),
                Text(
                  product.namaItem,
                  style: TextStyles.large(
                      color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
                Text(
                  product.sku,
                  style: TextStyles.small(
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  product.jenisItem,
                  style: TextStyles.small(
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  formatCurrency(product.harga.toDouble()),
                  style: TextStyles.regular(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.007,
          ),
        ],
      ),
    );
  }
}
