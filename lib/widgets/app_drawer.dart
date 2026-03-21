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
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  static bool get _showDeveloperSection =>
      DateTime.now().isAfter(DateTime(2026, 6, 30));

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
                if (_showDeveloperSection) ...[
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.primaryBlue.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.code,
                                size: 20,
                                color: AppTheme.primaryBlue,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'App Developed by',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppTheme.primaryBlue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Pratap Sharma',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _DeveloperLinkTile(
                            icon: Icons.language,
                            label: 'pratapsharma.io',
                            onTap: () => _launchUrl('https://pratapsharma.io'),
                          ),
                          _DeveloperLinkTile(
                            icon: Icons.email_outlined,
                            label: 'hello@pratapsharma.io',
                            onTap: () =>
                                _launchUrl('mailto:hello@pratapsharma.io'),
                          ),
                          _DeveloperLinkTile(
                            icon: Icons.phone_outlined,
                            label: '+977 9869081517',
                            onTap: () => _launchUrl('tel:+9779869081517'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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

class _DeveloperLinkTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DeveloperLinkTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Icon(icon, size: 18, color: AppTheme.primaryBlue),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.primaryBlue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(Icons.open_in_new, size: 14, color: AppTheme.primaryBlue),
            ],
          ),
        ),
      ),
    );
  }
}
