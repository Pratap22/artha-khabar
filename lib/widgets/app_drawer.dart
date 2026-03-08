import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constants.dart';
import '../theme/app_theme.dart';
import '../screens/about_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/privacy_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _shareApp(BuildContext context) {
    Share.share(
      'अर्थ खबर - Nepal\'s Leading Economic News Portal\n${AppConstants.websiteUrl}',
      subject: 'अर्थ खबर - Economic News',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppTheme.primaryBlue,
            ),
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo_main.png',
                    height: 52,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Text(
                      'अर्थ खबर',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppConstants.tagline,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text(AppConstants.aboutUs),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_mail_outlined),
                  title: const Text(AppConstants.contactUs),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text(AppConstants.privacyPolicy),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text(AppConstants.shareApp),
                  onTap: () {
                    Navigator.pop(context);
                    _shareApp(context);
                  },
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Artha Khabar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                _SocialTile(
                  icon: Icons.facebook,
                  label: 'फेसबुक पेज',
                  onTap: () => _launchUrl(AppConstants.facebookUrl),
                ),
                _SocialTile(
                  icon: Icons.play_circle_filled,
                  label: 'युट्युब च्यानल',
                  onTap: () => _launchUrl(AppConstants.youtubeUrl),
                ),
                _SocialTile(
                  icon: Icons.video_library,
                  label: 'टिकटक पेज',
                  onTap: () => _launchUrl(AppConstants.tiktokUrl),
                ),
                _SocialTile(
                  icon: Icons.camera_alt,
                  label: 'इन्स्टाग्राम पेज',
                  onTap: () => _launchUrl(AppConstants.instagramUrl),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryBlue),
      title: Text(label),
      onTap: onTap,
    );
  }
}
