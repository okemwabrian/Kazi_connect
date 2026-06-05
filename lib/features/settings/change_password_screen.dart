import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter your new password below.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              _buildField('Current Password', true),
              const SizedBox(height: 20),
              _buildField('New Password', true),
              const SizedBox(height: 20),
              _buildField('Confirm New Password', true),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password changed successfully!')),
                  );
                  context.pop();
                },
                child: const Text('Update Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.deepNavy)),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            suffixIcon: const Icon(Icons.visibility_off_outlined),
          ),
        ),
      ],
    );
  }
}
