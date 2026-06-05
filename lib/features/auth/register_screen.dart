import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _selectedRole = 'Employer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButton(),
              const SizedBox(height: 20),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.deepNavy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Join the KaziConnect community today.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Join as a:',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _RoleOption(
                    title: 'Employer',
                    icon: Icons.person_search_rounded,
                    isSelected: _selectedRole == 'Employer',
                    onTap: () => setState(() => _selectedRole = 'Employer'),
                  ),
                  const SizedBox(width: 12),
                  _RoleOption(
                    title: 'Worker',
                    icon: Icons.work_rounded,
                    isSelected: _selectedRole == 'Worker',
                    onTap: () => setState(() => _selectedRole = 'Worker'),
                  ),
                  const SizedBox(width: 12),
                  _RoleOption(
                    title: 'Bureau',
                    icon: Icons.business_rounded,
                    isSelected: _selectedRole == 'Bureau',
                    onTap: () => setState(() => _selectedRole = 'Bureau'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const _RegisterField(label: 'Full Name', hint: 'John Doe', icon: Icons.person_outline),
              const SizedBox(height: 20),
              const _RegisterField(label: 'Email Address', hint: 'name@example.com', icon: Icons.email_outlined),
              const SizedBox(height: 20),
              const _RegisterField(label: 'Phone Number', hint: '+254 700 000000', icon: Icons.phone_android_outlined),
              const SizedBox(height: 20),
              const _RegisterField(label: 'Password', hint: 'Create a password', icon: Icons.lock_outline, isPassword: true),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go('/main'),
                child: const Text('Create Account'),
              ),
              const SizedBox(height: 24),
              Center(
                child: TextButton(
                  onPressed: () => context.pop(),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.grey.shade600),
                      children: const [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(color: AppTheme.emeraldGreen, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleOption({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.emeraldGreen : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppTheme.emeraldGreen : Colors.grey.shade300,
            ),
            boxShadow: isSelected ? [
              BoxShadow(
                color: AppTheme.emeraldGreen.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ] : [],
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : AppTheme.deepNavy,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : AppTheme.deepNavy,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;

  const _RegisterField({
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: isPassword ? const Icon(Icons.visibility_off_outlined) : null,
          ),
        ),
      ],
    );
  }
}
