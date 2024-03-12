import 'package:beaja_toko/models/product/get_item/get_item_response_model.dart';
import 'package:beaja_toko/pages/product/list_product/widgets/list_product_card.dart';
import 'package:flutter/material.dart';

class ListProductGridView extends StatefulWidget {
  final List<ListItem> data;
  const ListProductGridView({
    super.key,
    required this.data,
  });

  @override
  State<ListProductGridView> createState() => _ListProductGridViewState();
}

class _ListProductGridViewState extends State<ListProductGridView> {
  @override
  Widget build(BuildContext context) {
    final listData = widget.data;
    // Determine maxCrossAxisExtent based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double maxItemWidth = screenWidth / 2 - 9 * 1.5;
    double maxCrossAxisExtent = maxItemWidth;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxCrossAxisExtent,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.6,
      ),
      itemCount: listData.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListProductCard(dataProduct: listData[index]),
        );
      },
    );
  }
}
