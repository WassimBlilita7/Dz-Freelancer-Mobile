import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_colors.dart';
import 'package:wassit_freelancer_dz_flutter/constants/app_text_styles.dart';
import 'package:wassit_freelancer_dz_flutter/core/controllers/app_bar_controller.dart';
import 'package:wassit_freelancer_dz_flutter/core/models/app_bar_model.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/api_services.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/animated_bottom_nav_bar.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/custom_app_bar.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/theme_toggle_button.dart';
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
      backgroundColor: AppColors.getBackground(context), // Utilisation de la couleur dynamique
      appBar: CustomAppBar(
        model: AppBarModel(unreadNotifications: 2),
        controller: _appBarController,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.getText(context),
                  ),
                ),
                SizedBox(height: 20.h),
                ListTile(
                  leading: Icon(
                    Icons.brightness_6,
                    color: AppColors.getText(context),
                  ),
                  title: Text(
                    'Changer de thème',
                    style: AppTextStyles.subtitleMedium.copyWith(
                      color: AppColors.getText(context),
                    ),
                  ),
                  trailing: const ThemeToggleButton(),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: AppColors.getText(context),
                  ),
                  title: Text(
                    'Profil',
                    style: AppTextStyles.subtitleMedium.copyWith(
                      color: AppColors.getText(context),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Naviguer vers la page de profil si nécessaire
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: AppColors.getText(context),
                  ),
                  title: Text(
                    'Paramètres',
                    style: AppTextStyles.subtitleMedium.copyWith(
                      color: AppColors.getText(context),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Naviguer vers la page de paramètres si nécessaire
                  },
                ),
              ],
            ),
          ),
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