import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/splash/splash_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/main/main_screen.dart';
import '../features/profile/worker_profile_screen.dart';
import '../features/jobs/job_details_screen.dart';
import '../features/chat/chat_detail_screen.dart';
import '../features/employer/employer_dashboard.dart';
import '../features/bureau/bureau_dashboard.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/home/category_results_screen.dart';
import '../features/jobs/application_success_screen.dart';
import '../features/profile/edit_profile_screen.dart';
import '../features/settings/change_password_screen.dart';
import '../features/profile/job_history_screen.dart';
import '../features/profile/saved_workers_screen.dart';
import '../features/settings/privacy_policy_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
    GoRoute(path: '/main', builder: (context, state) => const MainScreen()),
    GoRoute(path: '/worker-profile', builder: (context, state) => const WorkerProfileScreen()),
    GoRoute(path: '/job-details', builder: (context, state) => const JobDetailsScreen()),
    GoRoute(path: '/chat-detail', builder: (context, state) => const ChatDetailScreen()),
    GoRoute(path: '/employer-dashboard', builder: (context, state) => const EmployerDashboard()),
    GoRoute(path: '/bureau-dashboard', builder: (context, state) => const BureauDashboard()),
    GoRoute(path: '/notifications', builder: (context, state) => const NotificationsScreen()),
    GoRoute(path: '/application-success', builder: (context, state) => const ApplicationSuccessScreen()),
    GoRoute(path: '/edit-profile', builder: (context, state) => const EditProfileScreen()),
    GoRoute(path: '/change-password', builder: (context, state) => const ChangePasswordScreen()),
    GoRoute(path: '/job-history', builder: (context, state) => const JobHistoryScreen()),
    GoRoute(path: '/saved-workers', builder: (context, state) => const SavedWorkersScreen()),
    GoRoute(path: '/privacy-policy', builder: (context, state) => const PrivacyPolicyScreen()),
    GoRoute(
      path: '/category/:name',
      builder: (context, state) {
        final category = state.pathParameters['name']!;
        return CategoryResultsScreen(category: category);
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Page not found: ${state.uri}')),
  ),
);
