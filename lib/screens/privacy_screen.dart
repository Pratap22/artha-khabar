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
              'गोपनीयता नीति (Privacy Policy)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'हामी हाम्रा पाठकहरूको गोपनीयतालाई उच्च प्राथमिकता दिन्छौँ।',
              style: TextStyle(fontSize: 14, height: 1.6, color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),
            Text(
              'हामी वेबसाइट सुधार, सामग्री व्यवस्थापन तथा प्रयोगकर्ताको अनुभव राम्रो बनाउन सीमित डाटा (जस्तै: कुकीज वा सामान्य एनालिटिक्स) प्रयोग गर्न सक्छौं।',
              style: TextStyle(fontSize: 14, height: 1.6, color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),
            Text(
              'हाम्रो वेबसाइटमा प्रकाशित सामग्री वा लिङ्कमार्फत अन्य वेबसाइटमा जाँदा त्यहाँको गोपनीयता नीतिको जिम्मेवारी सम्बन्धित वेबसाइटकै हुनेछ।',
              style: TextStyle(fontSize: 14, height: 1.6, color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),
            Text(
              'यस वेबसाइट प्रयोग गरेर तपाईंले हाम्रो गोपनीयता नीति स्वीकार गर्नुभएको मानिनेछ । भविष्यमा आवश्यक परेमा यो नीति समय-समयमा परिमार्जन गर्न सकिनेछ।',
              style: TextStyle(fontSize: 14, height: 1.6, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
