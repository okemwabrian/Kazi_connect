import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../shared/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Column(
            children: [
              _buildProfileHeader(context),
              const SizedBox(height: 24),
              _buildQuickStats(),
              const SizedBox(height: 32),
              _buildSectionTitle('My Activity'),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    KaziTile(
                      icon: Icons.history_rounded,
                      title: 'Job History',
                      trailing: _buildBadge('12'),
                      onTap: () => context.push('/job-history'),
                    ),
                    KaziTile(
                      icon: Icons.favorite_border_rounded,
                      title: 'Saved Workers',
                      trailing: _buildBadge('5'),
                      onTap: () => context.push('/saved-workers'),
                    ),
                    KaziTile(
                      icon: Icons.assignment_outlined,
                      title: 'My Job Posts',
                      trailing: _buildBadge('3'),
                      onTap: () => context.push('/employer-dashboard'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Account Settings'),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    KaziTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Personal Information',
                      onTap: () => context.push('/edit-profile'),
                    ),
                    KaziTile(
                      icon: Icons.lock_outline_rounded,
                      title: 'Change Password',
                      onTap: () => context.push('/change-password'),
                    ),
                    KaziTile(
                      icon: Icons.verified_user_outlined,
                      title: 'Verification Status',
                      subtitle: 'Verified',
                      iconColor: AppTheme.emeraldGreen,
                    ),
                    KaziTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      onTap: () => context.push('/notifications'),
                    ),
                    KaziTile(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      onTap: () => context.push('/privacy-policy'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Management'),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    KaziTile(
                      icon: Icons.dashboard_outlined,
                      title: 'Employer Dashboard',
                      onTap: () => context.push('/employer-dashboard'),
                    ),
                    KaziTile(
                      icon: Icons.admin_panel_settings_outlined,
                      title: 'Bureau Dashboard',
                      onTap: () => context.push('/bureau-dashboard'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OutlinedButton(
                  onPressed: () => context.go('/login'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.deepNavy, Color(0xFF1A3A5A)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Hero(
            tag: 'profile_pic',
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: AppTheme.emeraldGreen,
                  child: Icon(Icons.person, size: 80, color: Colors.white),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => context.push('/edit-profile'),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.gold,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.deepNavy, width: 2),
                      ),
                      child: const Icon(Icons.edit_rounded, size: 18, color: AppTheme.deepNavy),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Sarah Kamau',
            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: AppTheme.emeraldGreen, size: 16),
              const SizedBox(width: 4),
              Text(
                'Runda, Nairobi',
                style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: AppTheme.emeraldGreen.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: const TextStyle(color: AppTheme.emeraldGreen, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatItem(label: 'Jobs Posted', value: '3'),
        _StatItem(label: 'Workers Hired', value: '12'),
        _StatItem(label: 'Avg. Rating', value: '4.8'),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.deepNavy)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
