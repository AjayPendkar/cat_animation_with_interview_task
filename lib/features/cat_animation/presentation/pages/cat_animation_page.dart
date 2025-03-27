import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme_bloc.dart';
import '../../../../core/localization/localization_bloc.dart';
import '../../../../core/localization/app_localizations.dart';
import '../widgets/cat_widget.dart';

class CatAnimationPage extends StatelessWidget {
  const CatAnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(
              context.watch<ThemeBloc>().state.isDarkMode 
                ? Icons.light_mode 
                : Icons.dark_mode
            ),
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
          ),
          // Language toggle button
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
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
      body: const Center(
        child: CatWidget(),
      ),
    );
  }
} 