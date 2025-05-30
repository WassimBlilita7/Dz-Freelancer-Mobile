import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTile extends StatelessWidget {
  const AboutTile({super.key});

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Wassit Freelancer DZ',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 Wassit Freelancer DZ',
      children: [
        const SizedBox(height: 8),
        const Text('Une application moderne pour freelances et clients en Algérie.'),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final url = Uri.parse('https://wassitfreedz.com');
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
          child: const Text(
            'Visitez notre site web',
            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: const Text('À propos'),
      onTap: () => _showAboutDialog(context),
    );
  }
} 