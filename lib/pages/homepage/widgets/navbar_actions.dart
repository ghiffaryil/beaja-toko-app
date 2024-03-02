import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NavbarActions extends StatelessWidget {
  const NavbarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.chatbox_ellipses_outline)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.notifications_outlined))
      ],
    );
  }
}
