import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wassit_freelancer_dz_flutter/core/widgets/theme_toggle_button.dart';
import 'package:wassit_freelancer_dz_flutter/features/settings/widgets/language_picker_tile.dart';
import 'package:wassit_freelancer_dz_flutter/features/settings/widgets/notification_toggle_tile.dart';
import 'package:wassit_freelancer_dz_flutter/features/settings/widgets/about_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          const ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text('Thème'),
            trailing: ThemeToggleButton(),
          ),
          const Divider(),
          const LanguagePickerTile(),
          const Divider(),
          const NotificationToggleTile(),
          const Divider(),
          const AboutTile(),
        ],
      ),
    );
  }
} 