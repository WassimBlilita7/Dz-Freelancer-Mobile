import 'package:flutter/material.dart';

class NotificationToggleTile extends StatefulWidget {
  const NotificationToggleTile({super.key});

  @override
  State<NotificationToggleTile> createState() => _NotificationToggleTileState();
}

class _NotificationToggleTileState extends State<NotificationToggleTile> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notifications),
      title: const Text('Notifications'),
      trailing: Switch(
        value: _notificationsEnabled,
        onChanged: (value) {
          setState(() {
            _notificationsEnabled = value;
          });
          // TODO: Add notification logic here
        },
      ),
    );
  }
} 