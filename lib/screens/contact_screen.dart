import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constants.dart';
import '../theme/app_theme.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.contactUs),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'हामीलाई सम्पर्क गर्नुहोस्',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.language, color: AppTheme.primaryBlue),
              title: const Text('वेबसाइट'),
              subtitle: Text(AppConstants.websiteUrl),
              onTap: () => _launchUrl(AppConstants.websiteUrl),
            ),
            ListTile(
              leading: const Icon(Icons.facebook, color: AppTheme.primaryBlue),
              title: const Text('फेसबुक'),
              onTap: () => _launchUrl(AppConstants.facebookUrl),
            ),
            ListTile(
              leading: const Icon(Icons.play_circle_filled, color: AppTheme.primaryBlue),
              title: const Text('युट्युब'),
              onTap: () => _launchUrl(AppConstants.youtubeUrl),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppTheme.primaryBlue),
              title: const Text('इन्स्टाग्राम'),
              onTap: () => _launchUrl(AppConstants.instagramUrl),
            ),
          ],
        ),
      ),
    );
  }
}
