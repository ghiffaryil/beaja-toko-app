import 'package:flutter/material.dart';
import 'package:beaja_toko/common/constants/styles/colors.dart';

class NotificationBadge extends StatefulWidget {
  const NotificationBadge({super.key});

  @override
  State<NotificationBadge> createState() => _NotificationBadgeState();
}

class _NotificationBadgeState extends State<NotificationBadge> {
  @override
  void initState() {
    super.initState();
    // context.read<NotifBloc>().add(const NotifEvent.getNotif());
  }

  void reloadScreen() {
    // BlocProvider.of<NotifBloc>(context).add(const NotifEvent.getNotif());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context)
        //     .push(
        //       MaterialPageRoute(builder: (context) => const NotificationPage()),
        //     )
        //     .then((value) => reloadScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20, right: 5),
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 30,
            ),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(top: 5),
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.warning,
                    border: Border.all(color: AppColors.bg, width: 0)),
                child: const Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Center(
                    child: Text(
                      '1',
                      // 'unreadNotifications.length.toString()',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: AppColors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
