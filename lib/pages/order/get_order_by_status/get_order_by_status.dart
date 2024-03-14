import 'package:beaja_toko/bloc/order/finish_order/finish_order_bloc.dart';
import 'package:beaja_toko/bloc/order/get_order_by_status/get_order_by_status_bloc.dart';
import 'package:beaja_toko/bloc/order/receive_order/receive_order_bloc.dart';
import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:beaja_toko/common/constants/navigation/navigation_bottom_bar.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/styles/padding.dart';
import 'package:beaja_toko/common/constants/styles/styles.dart';
import 'package:beaja_toko/common/extension/helper/currency_helper.dart';
import 'package:beaja_toko/common/extension/helper/date_helper.dart';
import 'package:beaja_toko/common/extension/helper/time_helper.dart';
import 'package:beaja_toko/models/order/finish_order/finish_order_request_model.dart';
import 'package:beaja_toko/models/order/get_order_by_status/get_order_by_status_request_model.dart';
import 'package:beaja_toko/models/order/receive_order/receive_order_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOrderPage extends StatefulWidget {
  const ListOrderPage({super.key});

  @override
  State<ListOrderPage> createState() => _ListOrderPageState();
}

class _ListOrderPageState extends State<ListOrderPage> {
  int _selectedFilterStatus = 0;

  @override
  void initState() {
    super.initState();
    loadDataSource(0);
  }

  void loadDataSource(int statusOrder) {
    final requestModel = GetOrderByStatusRequestModel(orderStatus: statusOrder);
    context
        .read<GetOrderByStatusBloc>()
        .add(GetOrderByStatusEvent.getOrder(requestModel));
  }

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
          _buildfilterStatusHorizontalView(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: _buildOrderCard(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomMenu(
        selectedIndex: 2,
      ),
    );
  }

  Widget _buildfilterStatusHorizontalView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          _buildfilterStatusItem(0),
          _buildfilterStatusItem(1),
          _buildfilterStatusItem(2),
          _buildfilterStatusItem(3),
        ],
      ),
    );
  }

  Widget _buildfilterStatusItem(int filterStatus) {
    String textStatus = '';

    if (filterStatus == 0) {
      textStatus = "Belum diproses";
    } else if (filterStatus == 1) {
      textStatus = "Sudah dikonfirmasi";
    } else if (filterStatus == 2) {
      textStatus = "Sudah dipick up";
    } else {
      textStatus = "Selesai";
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilterStatus = filterStatus;
        });
        loadDataSource(filterStatus);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: _selectedFilterStatus == filterStatus
              ? AppColors.secondary
              : AppColors.light.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _selectedFilterStatus == filterStatus
                ? AppColors.white
                : AppColors.light,
            width: 1,
          ),
        ),
        child: Text(
          textStatus,
          style: TextStyle(
            color: _selectedFilterStatus == filterStatus
                ? AppColors.white
                : AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard() {
    return BlocBuilder<GetOrderByStatusBloc, GetOrderByStatusState>(
        builder: (context, state) {
      return state.maybeWhen(orElse: () {
        return const Center(
          child: Text('List is Empty'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }, error: (message) {
        return Center(
          child: Text(message),
        );
      }, loaded: (data) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.data.length,
          itemBuilder: (context, index) {
            final dataOrder = data.data[index];
            // Count Total Harga
            int totalHarga = 0;
            // Calculate total harga
            for (var orderDetail in dataOrder.orderDetails) {
              totalHarga += orderDetail.qty * orderDetail.harga;
            }

            return Container(
              padding: CustomPadding.p2,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dataOrder.namaPembeli,
                        style: TextStyles.h4(),
                      ),
                      Text(
                        '${dataOrder.createdAt.formatDateId()} - ${dataOrder.createdAt.formatTime()}',
                        style: TextStyles.small(color: AppColors.muted),
                      ),
                    ],
                  ),
                  Text(
                    'Total Pesanan: ${dataOrder.orderDetails.length.toString()}',
                    style: TextStyles.regular(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Text(
                          formatCurrency(totalHarga.toDouble()),
                          style: TextStyles.h4(color: AppColors.secondary),
                        ),
                      ),
                      _selectedFilterStatus < 4
                          ? Expanded(
                              flex: 3,
                              child: _selectedFilterStatus == 0
                                  ? buttonConfirmationOrder(dataOrder.id)
                                  : _selectedFilterStatus == 1
                                      ? buttonFinishOrder(dataOrder.id)
                                      : Container(),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      });
    });
  }

  Widget buttonConfirmationOrder(int orderId) {
    return BlocProvider(
      create: (context) => ReceiveOrderBloc(),
      child: BlocListener<ReceiveOrderBloc, ReceiveOrderState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showDialogOrder(data.message);
                },
                barrierDismissible: false,
              );
            },
          );
        },
        child: BlocBuilder<ReceiveOrderBloc, ReceiveOrderState>(
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return ButtonFilled.primary(
                  height: 30,
                  width: 80,
                  text: 'Terima',
                  onPressed: () {
                    final requestModel =
                        ReceiveOrderRequestModel(orderId: orderId);
                    context
                        .read<ReceiveOrderBloc>()
                        .add(ReceiveOrderEvent.receiveOrder(requestModel));
                  });
            }, loading: () {
              return ButtonFilled.primary(
                text: ' ',
                onPressed: () {},
                loading: true,
              );
            });
          },
        ),
      ),
    );
  }

  Widget buttonFinishOrder(int orderId) {
    return BlocProvider(
      create: (context) => FinishOrderBloc(),
      child: BlocListener<FinishOrderBloc, FinishOrderState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loaded: (data) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showDialogOrder(data.message);
                },
                barrierDismissible: false,
              );
            },
          );
        },
        child: BlocBuilder<FinishOrderBloc, FinishOrderState>(
          builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return ButtonFilled.primary(
                  height: 30,
                  width: 80,
                  text: 'Pick Up',
                  onPressed: () {
                    final requestModel =
                        FinishOrderRequestModel(orderId: orderId);
                    context
                        .read<FinishOrderBloc>()
                        .add(FinishOrderEvent.finishOrder(requestModel));
                  });
            }, loading: () {
              return ButtonFilled.primary(
                text: ' ',
                onPressed: () {},
                loading: true,
              );
            });
          },
        ),
      ),
    );
  }

  // SHOW DIALOG
  Widget showDialogOrder(String pesan) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      title: Text(
        'Sukses!',
        style: TextStyles.h4(),
      ),
      content: SizedBox(
        height: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pesan,
              style: TextStyles.extraLarge(),
            ),
          ],
        ),
      ),
      actions: [
        ButtonFilled.secondary(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const ListOrderPage();
            }));
          },
          height: 40,
          width: 80,
          text: 'OK',
        )
      ],
    );
  }
}
