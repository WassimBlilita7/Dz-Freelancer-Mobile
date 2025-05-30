import 'package:flutter/material.dart';

class LanguagePickerTile extends StatefulWidget {
  const LanguagePickerTile({super.key});

  @override
  State<LanguagePickerTile> createState() => _LanguagePickerTileState();
}

class _LanguagePickerTileState extends State<LanguagePickerTile> {
  String _selectedLanguage = 'Français';
  final List<String> _languages = ['Français', 'English', 'العربية'];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: const Text('Langue'),
      trailing: DropdownButton<String>(
        value: _selectedLanguage,
        items: _languages.map((lang) => DropdownMenuItem(
          value: lang,
          child: Text(lang),
        )).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedLanguage = value;
            });
            // TODO: Add localization logic here
          }
        },
      ),
    );
  }
} 