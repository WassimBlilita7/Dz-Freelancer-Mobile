import 'package:flutter/material.dart';

class NavItem {
  final IconData icon;
  final int index;

  NavItem({
    required this.icon,
    required this.index,
  });

  static List<NavItem> getNavItems() {
    return [
      NavItem(icon: Icons.home, index: 0),
      NavItem(icon: Icons.pie_chart, index: 1),
      NavItem(icon: Icons.account_circle, index: 2),
      NavItem(icon: Icons.search, index: 3),
    ];
  }
}