import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Cat Animation',
      'toggleTheme': 'Toggle Theme',
      'changeLanguage': 'Change Language',
      'login': 'Login',
      'loginDescription': 'Lorem Ipsum is simply dummy text of the printing\nand typesetting industry.',
      'noAccount': "DON'T HAVE ACCOUNT ? ",
      'register': 'REGISTER',
    },
    'es': {
      'appTitle': 'Animación de Gato',
      'toggleTheme': 'Cambiar Tema',
      'changeLanguage': 'Cambiar Idioma',
      'login': 'Iniciar Sesión',
      'loginDescription': 'Lorem Ipsum es simplemente texto de relleno\nde la industria de la impresión.',
      'noAccount': '¿NO TIENES CUENTA? ',
      'register': 'REGISTRARSE',
    },
  };

  String get appTitle => _localizedValues[locale.languageCode]?['appTitle'] ?? '';
  String get toggleTheme => _localizedValues[locale.languageCode]?['toggleTheme'] ?? '';
  String get changeLanguage => _localizedValues[locale.languageCode]?['changeLanguage'] ?? '';
  String get login => _localizedValues[locale.languageCode]?['login'] ?? '';
  String get loginDescription => _localizedValues[locale.languageCode]?['loginDescription'] ?? '';
  String get noAccount => _localizedValues[locale.languageCode]?['noAccount'] ?? '';
  String get register => _localizedValues[locale.languageCode]?['register'] ?? '';

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('es'),
  ];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
} 