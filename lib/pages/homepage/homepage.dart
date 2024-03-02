import 'package:beaja_toko/bloc/profile/get_user_details/get_user_details_bloc.dart';
import 'package:beaja_toko/common/components/divider.dart';
import 'package:beaja_toko/common/constants/function/show_toast.dart';
import 'package:beaja_toko/common/constants/navigation/navigation_bottom_bar.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/functions/check_token/check_token.dart';
import 'package:beaja_toko/common/functions/logout/logout_loaded_response.dart';
import 'package:beaja_toko/pages/homepage/widgets/navbar_actions.dart';
import 'package:beaja_toko/pages/homepage/widgets/navbar_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  bool isLogged = false;
  bool isExpiredToken = false;
  String userToken = '';
  int userId = 0;

  // POSITION
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;

  String namaToko = '';
  String alamat = '';

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    checkGpsPermission();
    checkToken();
  }

  void checkGpsPermission() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showToast(message: 'Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          showToast(message: "Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
    } else {
      showToast(message: 'GPS Service is not enabled, turn on GPS location');
    }
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

        if (isExpiredToken) {
          showToast(message: 'Token Expired');
          logoutLoadedFunction(context);
        } else {
          print(userId);
          print(userToken);
          print('userToken: $userToken');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: BlocBuilder<GetUserDetailsBloc, GetUserDetailsState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const NavbarTitle(
                  namaToko: '-',
                  alamatToko: '-',
                );
              },
              loaded: (data) {
                if (data.userDetail.isNotEmpty) {
                  return NavbarTitle(
                    namaToko: data.userDetail.first.namaDepan,
                    alamatToko:
                        '${data.userDetail.first.desa} ${data.userDetail.first.noRumah}',
                  );
                } else {
                  return const NavbarTitle(
                    namaToko: '',
                    alamatToko: '',
                  );
                }
              },
              error: (message) {
                return const NavbarTitle(
                  namaToko: '-',
                  alamatToko: '-',
                );
              },
            );
          },
        ),
        actions: const [NavbarActions()],
      ),
      body: Container(
        padding: CustomPadding.p2,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order of Delivery Food',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CustomDividers.verySmallDivider(),
              SizedBox(
                height: 150, // Adjust height according to your needs
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Change itemCount as per your data
                  itemBuilder: (context, index) {
                    // Replace Container with your order item widget
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 250, // Adjust width according to your needs
                      decoration: BoxDecoration(
                        color: AppColors.bg.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Text('Order ${index + 1}')),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total \nOrders',
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '10', // Replace with your total orders count
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total \nSaldo',
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '10', // Replace with your total orders count
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Order Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Container for order statuses
              Column(
                children: [
                  // Example container for an order status
                  _buildOrderStatus('Not ready to process', 2),
                  _buildOrderStatus('Order processed', 5),
                  _buildOrderStatus('In delivery', 3),
                  _buildOrderStatus('Delivered', 10),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomMenu(
        selectedIndex: selectedIndex,
      ),
    );
  }

  Widget _buildOrderStatus(String status, int count) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 7,
              child: Text(
                status,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                count.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_rounded)),
            )
          ],
        ),
      ),
    );
  }
}
