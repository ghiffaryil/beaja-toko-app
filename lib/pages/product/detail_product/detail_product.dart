import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:beaja_toko/common/components/image_rounded.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({super.key});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        title: const Text('Details'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Ionicons.heart_outline,
                color: AppColors.danger,
                size: 30,
              ))
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: CustomPadding.p3,
                    child: Column(
                      children: [
                        RoundedImage(
                            borderRadius: 20,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.35,
                            fit: BoxFit.fitWidth,
                            imageUrl:
                                'https://s41230.pcdn.co/wp-content/uploads/2017/10/vegan-plant-based-news-kfc.jpg',
                            imageType: 'url'),
                        CustomDividers.smallDivider(),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.secondary),
                            padding: const EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.time_to_leave),
                                            Text(' 15 mins'),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Delivery',
                                          style: TextStyles.regular(
                                              color: AppColors.muted),
                                        ),
                                      ],
                                    )),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              width: 1, color: AppColors.white),
                                          right: BorderSide(
                                              width: 1,
                                              color: AppColors.white)),
                                    ),
                                    // margin: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.chat_outlined),
                                            Text(' 32 +'),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Reviews',
                                          style: TextStyles.regular(
                                              color: AppColors.muted),
                                        ),
                                      ],
                                    )),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.star_border_outlined),
                                            Text(' 4.5'),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Ratings',
                                          style: TextStyles.regular(
                                              color: AppColors.muted),
                                        ),
                                      ],
                                    )),
                              ],
                            )),
                        CustomDividers.smallDivider(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Title of Product test ok 12341 SIP',
                                    style:
                                        TextStyles.h4(color: AppColors.light),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text('Rp 49.000,-',
                                      style: TextStyles.regular(
                                        color: AppColors.primary,
                                      )),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                      onPressed: () {
                                        // Minus button logic
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: const SizedBox(
                                      width: 50,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            hintText: '0',
                                            hintStyle: TextStyle(
                                                color: AppColors.indicator),
                                            border: InputBorder.none),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 25),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: IconButton(
                                      onPressed: () {
                                        // Add button logic
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        CustomDividers.verySmallDivider(),
                        const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus, velit nec aliquet tincidunt, justo nisl ultrices nunc, nec lacinia risus odio id nunc. Nulla facilisi. Sed euismod, mauris id tincidunt tincidunt, arcu nisl ultricies nunc, id aliquam nunc nisl id nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus, velit nec aliquet tincidunt, justo nisl ultrices nunc, nec lacinia risus odio id nunc. Nulla facilisi. Sed euismod, mauris id tincidunt tincidunt, arcu nisl ultricies nunc, id aliquam nunc nisl id nunc.'),
                        CustomDividers.smallDivider(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                margin: const EdgeInsets.only(bottom: 15, top: 15),
                color: AppColors.white,
                child: ButtonFilled.custom(
                    iconData: Ionicons.bag_add_outline,
                    text: 'Add to Cart',
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
                    onPressed: () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
