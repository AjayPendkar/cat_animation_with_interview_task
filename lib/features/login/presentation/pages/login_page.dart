import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cat_animation/presentation/widgets/cat_widget.dart';
import '../../../../main.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/theme_bloc.dart';
import '../../../../core/localization/localization_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // Theme toggle
          IconButton(
            icon: Icon(
              context.watch<ThemeBloc>().state.isDarkMode 
                ? Icons.light_mode 
                : Icons.dark_mode,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
          ),
          // Language toggle
          PopupMenuButton<String>(
            icon: Icon(
              Icons.language,
              color: Theme.of(context).primaryColor,
            ),
            onSelected: (String languageCode) {
              context.read<LocalizationBloc>().add(
                ChangeLanguageEvent(languageCode),
              );
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
                const PopupMenuItem(
                  value: 'es',
                  child: Text('Español'),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // Cat animation container
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: CatWidget(),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                localizations.login,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              Text(
                localizations.loginDescription,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              // Login button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SmartLightingPreview(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCE7BB0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  localizations.login,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Register link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizations.noAccount,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add registration navigation here
                    },
                    child: Text(
                      localizations.register,
                      style: const TextStyle(
                        color: Color(0xFFCE7BB0),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 