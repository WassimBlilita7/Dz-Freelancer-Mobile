import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/core/controllers/app_bar_controller.dart';
import 'package:wassit_freelancer_dz_flutter/core/models/app_bar_model.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/api_services.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/category_api_service.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/animated_bottom_nav_bar.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_app_bar.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_drawer.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/controllers/home_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/providers/home_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/post/screens/post_list_screen.dart';
import 'package:wassit_freelancer_dz_flutter/features/main/views/user_tab.dart';
import 'package:wassit_freelancer_dz_flutter/features/main/views/search_tab.dart';

import '../../main/views/home_tab.dart';

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
    _controller = HomeController(provider, ApiService(), CategoryApiService());
    provider.controller = _controller;

    _appBarController = AppBarController(
      onMenuPressed: _openDrawer,
      onMessagesPressed: _navigateToMessages,
    );
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _navigateToMessages() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigation vers la page de messages')),
    );
  }

  void _handleLogout() {
    _controller.logout(context);
  }

  final List<Widget> _tabs = const [
    HomeTab(),
    PostListScreen(), // Remplacé ChartTab par PostListScreen
    UserTab(),
    NotificationsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.getBackground(context),
      appBar: CustomAppBar(
        model: AppBarModel(unreadNotifications: 2),
        controller: _appBarController,
      ),
      drawer: CustomDrawer(
        onLogout: _handleLogout,
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