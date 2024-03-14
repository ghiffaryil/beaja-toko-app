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
    String displayedName = product.namaItem.length > 12
        ? "${product.namaItem.substring(0, 12)} ..."
        : product.namaItem;
    String jenisItem = product.jenisItem;
    String volumeItem =
        product.jenisItem == "minuman" ? '- ${product.volume}' : '';

    return Container(
      padding: const EdgeInsets.all(6),
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
            padding: const EdgeInsets.all(5.0),
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDividers.verySmallDivider(),
                Text(
                  displayedName,
                  style: TextStyles.large(
                      color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
                Text(
                  product.sku,
                  style: TextStyles.small(color: AppColors.muted),
                ),
                Text(
                  '$jenisItem $volumeItem ',
                  style: TextStyles.small(color: AppColors.muted),
                ),
                CustomDividers.smallDivider(),
                Text(
                  formatCurrency(product.harga.toDouble()),
                  style: TextStyles.medium(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
