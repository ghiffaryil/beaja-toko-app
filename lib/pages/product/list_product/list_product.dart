import 'package:beaja_toko/bloc/product/get_item/get_item_bloc.dart';
import 'package:beaja_toko/common/constants/navigation/navigation_bottom_bar.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/functions/check_token/check_token.dart';
import 'package:beaja_toko/models/product/get_item/get_item_request_model.dart';
import 'package:beaja_toko/pages/product/create_product/create_product.dart';
import 'package:beaja_toko/pages/product/list_product/widgets/list_product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({super.key});

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  int selectedIndex = 1;
  bool isLogged = false;
  bool isExpiredToken = false;
  String userToken = '';
  int userId = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = 1;
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
        print(userToken);
        loadDataSource(userId);
      },
    );
  }

  void loadDataSource(int id) {
    final requestModel = GetItemRequestModel(userId: id);
    context.read<GetItemBloc>().add(GetItemEvent.getItem(requestModel));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        title: const Text('Product List'),
      ),
      body: Container(
          padding: CustomPadding.p1,
          child: BlocBuilder<GetItemBloc, GetItemState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Container();
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.secondary,
                    ),
                  );
                },
                loaded: (data) {
                  final listData = data.data;
                  return ListProductGridView(data: listData);
                },
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CreateProduct();
          }));
        },
        shape: const CircleBorder(),
        elevation: 2,
        backgroundColor: AppColors.secondary,
        child: const Icon(
          Icons.add,
          color: AppColors.white,
          size: 35,
        ),
      ),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
    );
  }
}
