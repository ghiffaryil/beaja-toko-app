import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/common/functions/check_token/check_token.dart';
import 'package:beaja_toko/pages/product/create_product/widgets/form/form_input_create_product.dart';
import 'package:beaja_toko/pages/product/list_product/list_product.dart';
import 'package:flutter/material.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  bool isLogged = false;
  bool isExpiredToken = false;
  String userToken = '';
  int userId = 0;

  @override
  void initState() {
    super.initState();
    print('Create Product');
    checkToken();
  }

  void checkToken() {
    TokenChecker.checkToken(
      setStateCallback: (bool getIsLogged, String getUserToken,
          String getUserEmail, bool getIsExpiredToken, int getUserId) {
        setState(() {
          isLogged = getIsLogged;
          isExpiredToken = getIsExpiredToken;
          userToken = getUserToken;
          userId = getUserId;
        });
        print(userId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          'Tambah Item',
          style: TextStyles.h3(color: AppColors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ListProductPage();
            }));
          },
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Container(
        color: AppColors.white,
        width: double.infinity,
        padding: CustomPadding.p2,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              FormInputCreateProduct(
                userId: userId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
