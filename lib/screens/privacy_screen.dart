import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../theme/app_theme.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.privacyPolicy),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'प्राइभेसी पोलिसी',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'अर्थ खबर एपले तपाईंको गोपनीयताको सम्मान गर्दछ। यो एपले Arthakhabar.com को सामग्री प्रदर्शन गर्न प्रयोग गरिन्छ र तपाईंको डाटा सुरक्षित रूपमा राखिन्छ।',
              style: TextStyle(height: 1.6, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            Text(
              'कुनै पनि प्रश्नको लागि हामीलाई ${AppConstants.websiteUrl} मार्फत सम्पर्क गर्नुहोस्।',
              style: TextStyle(height: 1.6, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
