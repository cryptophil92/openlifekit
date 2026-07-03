import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_life_kit/core/routing/app_routes.dart';
import 'package:open_life_kit/features/settings/application/app_settings_actions.dart';
import 'package:open_life_kit/features/settings/application/app_settings_providers.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Spacer(),
              Icon(
                Icons.lock_outline,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'OpenLifeKit',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Gardez vos informations essentielles sur votre telephone, sans compte obligatoire.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              const Text('Local par defaut.'),
              const Text('Utilisable hors ligne.'),
              const Text('Partage uniquement volontaire.'),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    final current = ref.read(appSettingsProvider);
                    ref.read(appSettingsProvider.notifier).state =
                        AppSettingsActions.withIntroAccepted(current);
                    context.go(AppRoutes.home);
                  },
                  child: const Text('Commencer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
