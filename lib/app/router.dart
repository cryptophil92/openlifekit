import 'package:go_router/go_router.dart';
import 'package:open_life_kit/core/routing/app_routes.dart';
import 'package:open_life_kit/features/checklists/presentation/checklists_screen.dart';
import 'package:open_life_kit/features/contacts/presentation/contacts_screen.dart';
import 'package:open_life_kit/features/documents/presentation/documents_screen.dart';
import 'package:open_life_kit/features/emergency_card/presentation/emergency_card_screen.dart';
import 'package:open_life_kit/features/home/presentation/home_screen.dart';
import 'package:open_life_kit/features/onboarding/presentation/onboarding_screen.dart';
import 'package:open_life_kit/features/profile/presentation/profile_screen.dart';
import 'package:open_life_kit/features/settings/presentation/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.emergencyCard,
      name: 'emergency-card',
      builder: (context, state) => const EmergencyCardScreen(),
    ),
    GoRoute(
      path: AppRoutes.contacts,
      name: 'contacts',
      builder: (context, state) => const ContactsScreen(),
    ),
    GoRoute(
      path: AppRoutes.documents,
      name: 'documents',
      builder: (context, state) => const DocumentsScreen(),
    ),
    GoRoute(
      path: AppRoutes.checklists,
      name: 'checklists',
      builder: (context, state) => const ChecklistsScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
