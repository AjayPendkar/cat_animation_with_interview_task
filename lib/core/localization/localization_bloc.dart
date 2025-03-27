import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Events
abstract class LocalizationEvent {}

class ChangeLanguageEvent extends LocalizationEvent {
  final String languageCode;
  ChangeLanguageEvent(this.languageCode);
}

class LoadLocaleEvent extends LocalizationEvent {}

// States
class LocalizationState {
  final Locale locale;

  LocalizationState({required this.locale});
}

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final SharedPreferences prefs;
  static const String _localeKey = 'languageCode';

  LocalizationBloc({required this.prefs}) : super(LocalizationState(locale: const Locale('en'))) {
    on<LoadLocaleEvent>(_loadLocale);
    on<ChangeLanguageEvent>(_changeLanguage);
  }

  Future<void> _loadLocale(LoadLocaleEvent event, Emitter<LocalizationState> emit) async {
    final languageCode = prefs.getString(_localeKey) ?? 'en';
    emit(LocalizationState(locale: Locale(languageCode)));
  }

  Future<void> _changeLanguage(ChangeLanguageEvent event, Emitter<LocalizationState> emit) async {
    await prefs.setString(_localeKey, event.languageCode);
    emit(LocalizationState(locale: Locale(event.languageCode)));
  }
} 