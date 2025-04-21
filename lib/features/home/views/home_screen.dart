import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wassit_freelancer_dz_flutter/core/services/api_services.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/animated_bottom_nav_bar.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/controllers/home_controller.dart';
import 'package:wassit_freelancer_dz_flutter/features/home/providers/home_provider.dart';
import 'package:wassit_freelancer_dz_flutter/features/main/views/chart_tab.dart';
import 'package:wassit_freelancer_dz_flutter/features/main/views/clock_tab.dart';
import 'package:wassit_freelancer_dz_flutter/features/main/views/home_tab.dart';
import 'package:wassit_freelancer_dz_flutter/features/main/views/notifications_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomeProvider>(context, listen: false);
    _controller = HomeController(provider, ApiService());
    provider.controller = _controller;
  }

  final List<Widget> _tabs = const [
    HomeTab(),
    ChartTab(),
    ClockTab(),
    NotificationsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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