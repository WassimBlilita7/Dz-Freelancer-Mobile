import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wassit_freelancer_dz_flutter/core/controllers/nav_bar_controller.dart';
import 'package:wassit_freelancer_dz_flutter/core/models/nav_item.dart';

class AnimatedBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const AnimatedBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  Widget _buildNavBarContainer(BuildContext context, List<Widget> children) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // Fond blanc ou gris foncé selon le thème
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = NavBarController(onItemTapped: onItemTapped);

    return _buildNavBarContainer(
      context,
      controller.navItems
          .map((item) => NavBarItem(
        item: item,
        isSelected: selectedIndex == item.index,
        onTap: controller.handleItemTap,
      ))
          .toList(),
    );
  }
}

class NavBarItem extends StatefulWidget {
  final NavItem item;
  final bool isSelected;
  final ValueChanged<int> onTap;

  const NavBarItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void didUpdateWidget(covariant NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIcon(BuildContext context) {
    return Icon(
      widget.item.icon,
      size: 28.sp,
      color: widget.isSelected
          ? Theme.of(context).colorScheme.primary // Violet foncé pour l'icône sélectionnée
          : Theme.of(context).colorScheme.secondary, // Gris pour les icônes non sélectionnées
    )
        .animate(controller: _controller)
        .scaleXY(
      begin: 1.0,
      end: 1.3,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    )
        .then()
        .scaleXY(
      begin: 1.3,
      end: 1.0,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    )
        .moveY(
      begin: 0,
      end: -8.h,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    )
        .then()
        .moveY(
      begin: -8.h,
      end: 0,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.item.index);
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 40.w) / 4,
        height: 50.h,
        decoration: BoxDecoration(
          color: widget.isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.2) // Fond violet clair pour l'élément sélectionné
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: _buildIcon(context),
        ),
      ),
    );
  }
}