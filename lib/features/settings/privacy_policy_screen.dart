import 'package:flutter/material.dart';
import '../../shared/widgets.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          maxWidth: 800,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your privacy is important to us.',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                _buildSection('1. Data Collection', 'We collect information you provide directly to us, such as when you create or modify your account, request services, or communicate with us.'),
                _buildSection('2. Use of Information', 'We use the information we collect to provide, maintain, and improve our services, and to communicate with you about your account.'),
                _buildSection('3. Sharing of Information', 'We do not share your personal information with third parties except as described in this policy.'),
                const SizedBox(height: 48),
                const Text('Last updated: June 2024', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 16, color: Colors.grey, height: 1.5)),
        ],
      ),
    );
  }
}
