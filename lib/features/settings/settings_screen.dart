import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileSection(),
            const SizedBox(height: 20),
            _buildSettingsGroup('Account', [
              _SettingsTile(icon: Icons.person_outline, title: 'Edit Profile', onTap: () {}),
              _SettingsTile(icon: Icons.verified_user_outlined, title: 'Verification Status', onTap: () {}),
              _SettingsTile(icon: Icons.payments_outlined, title: 'Payment Methods', onTap: () {}),
            ]),
            _buildSettingsGroup('Preferences', [
              _SettingsTile(icon: Icons.notifications_none_outlined, title: 'Notifications', onTap: () {}),
              _SettingsTile(icon: Icons.dark_mode_outlined, title: 'Dark Mode', trailing: Switch(value: false, onChanged: (v) {})),
              _SettingsTile(icon: Icons.language_outlined, title: 'Language', subtitle: 'English'),
            ]),
            _buildSettingsGroup('Security', [
              _SettingsTile(icon: Icons.lock_outline, title: 'Change Password', onTap: () {}),
              _SettingsTile(icon: Icons.privacy_tip_outlined, title: 'Privacy Policy', onTap: () {}),
            ]),
            _buildSettingsGroup('Dashboards (Demo)', [
              _SettingsTile(icon: Icons.dashboard_outlined, title: 'Employer Dashboard', onTap: () => context.push('/employer-dashboard')),
              _SettingsTile(icon: Icons.admin_panel_settings_outlined, title: 'Bureau Dashboard', onTap: () => context.push('/bureau-dashboard')),
            ]),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                onPressed: () => context.go('/login'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: const Text('Logout'),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: AppTheme.deepNavy,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: AppTheme.emeraldGreen,
            child: Icon(Icons.person, color: Colors.white, size: 50),
          ),
          const SizedBox(width: 20),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sarah Kamau',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Employer Account',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        ...children,
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.deepNavy),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing ?? const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
