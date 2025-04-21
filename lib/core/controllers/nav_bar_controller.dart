import 'package:flutter/material.dart';
import 'package:wassit_freelancer_dz_flutter/core/models/nav_item.dart';

class NavBarController {
  final ValueChanged<int> onItemTapped;
  final List<NavItem> navItems;

  NavBarController({
    required this.onItemTapped,
  }) : navItems = NavItem.getNavItems();

  void handleItemTap(int index) {
    onItemTapped(index);
  }
}