import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/core/controllers/app_bar_controller.dart';
import 'package:wassit_freelancer_dz_flutter/core/models/app_bar_model.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/api_services.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/animated_bottom_nav_bar.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_app_bar.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/controllers/home_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/providers/home_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/main/views/chart_tab.dart';
import 'package:wassit_freelancer_dz_flutter/features/main/views/home_tab.dart';
import 'package:wassit_freelancer_dz_flutter/features/main/views/user_tab.dart';

import '../../main/views/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController _controller;
  late AppBarController _appBarController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomeProvider>(context, listen: false);
    _controller = HomeController(provider, ApiService());
    provider.controller = _controller;

    _appBarController = AppBarController(
      onMenuPressed: () {
        _scaffoldKey.currentState?.openDrawer();
      },
      onMessagesPressed: () {
        // Simuler une navigation vers une page de messages
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Navigation vers la page de messages')),
        );
      },
    );
  }

  final List<Widget> _tabs = const [
    HomeTab(),
    ChartTab(),
    UserTab(),
    NotificationsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        model: AppBarModel(unreadNotifications: 2), // 2 notifications non lues, comme dans l'image
        controller: _appBarController,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Menu',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            ListTile(
              title: const Text('Profil'),
              onTap: () {
                Navigator.pop(context);
                // Naviguer vers la page de profil si nécessaire
              },
            ),
            ListTile(
              title: const Text('Paramètres'),
              onTap: () {
                Navigator.pop(context);
                // Naviguer vers la page de paramètres si nécessaire
              },
            ),
          ],
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return _tabs[provider.model.selectedIndex];
        },
      ),
      bottomNavigationBar: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return AnimatedBottomNavBar(
            selectedIndex: provider.model.selectedIndex,
            onItemTapped: (index) {
              provider.setSelectedIndex(index);
            },
          );
        },
      ),
    );
  }
}