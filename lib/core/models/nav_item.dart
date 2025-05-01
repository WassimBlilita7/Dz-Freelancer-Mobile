import 'package:flutter/material.dart';

class NavItem {
  final IconData icon;
  final int index;
  final String label;

  NavItem({
    required this.icon,
    required this.index,
    required this.label,
  });

  static List<NavItem> getNavItems() {
    return [
      NavItem(icon: Icons.home, index: 0, label: 'Accueil'),
      NavItem(icon: Icons.work, index: 1, label: 'Offres'), // Changé de pie_chart à work
      NavItem(icon: Icons.account_circle, index: 2, label: 'Profil'),
      NavItem(icon: Icons.search, index: 3, label: 'Recherche'),
    ];
  }
}