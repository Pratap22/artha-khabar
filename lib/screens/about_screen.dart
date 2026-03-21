import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constants.dart';
import '../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _openWebsite() async {
    final uri = Uri.parse(AppConstants.websiteUrl);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.aboutUs),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_main.png',
              height: 120,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.newspaper,
                size: 80,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'अर्थ खबर डटकम नेपालको प्रिमियम आर्थिक सञ्चार माध्यम हो । मिडिया हन्ड्रेड प्रालिद्वारा संचालित यो समाचार पोर्टल २०८२ बैसाख देखि सञ्चालनमा आएको हो । विस्तृत विवरणका लागि अर्थ खबर डटकम हेर्न सक्नुहुनेछ ।',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, height: 1.6),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: _openWebsite,
              child: Text(
                AppConstants.websiteUrl,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.primaryBlue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppConstants.copyright,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
