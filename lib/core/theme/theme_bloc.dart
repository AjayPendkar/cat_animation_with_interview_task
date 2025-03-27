import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class LoadThemeEvent extends ThemeEvent {}

// States
class ThemeState {
  final bool isDarkMode;

  ThemeState({required this.isDarkMode});
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences prefs;
  static const String _themeKey = 'isDarkMode';

  ThemeBloc({required this.prefs}) : super(ThemeState(isDarkMode: false)) {
    on<LoadThemeEvent>(_loadTheme);
    on<ToggleThemeEvent>(_toggleTheme);
  }

  Future<void> _loadTheme(LoadThemeEvent event, Emitter<ThemeState> emit) async {
    final isDarkMode = prefs.getBool(_themeKey) ?? false;
    emit(ThemeState(isDarkMode: isDarkMode));
  }

  Future<void> _toggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    final isDarkMode = !state.isDarkMode;
    await prefs.setBool(_themeKey, isDarkMode);
    emit(ThemeState(isDarkMode: isDarkMode));
  }
} 