import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_bloc.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/localization_bloc.dart';
import 'features/login/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  
  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(prefs: prefs)..add(LoadThemeEvent()),
        ),
        BlocProvider(
          create: (context) => LocalizationBloc(prefs: prefs)..add(LoadLocaleEvent()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocalizationBloc, LocalizationState>(
            builder: (context, localeState) {
              return MaterialApp(
                title: 'Cat Animation',
                theme: themeState.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
                locale: localeState.locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: [
                  const AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                home: const LoginPage(),
                debugShowCheckedModeBanner: false,
              );
            },
          );
        },
      ),
    );
  }
}

class SmartLightingPreview extends StatefulWidget {
  const SmartLightingPreview({super.key});

  @override
  State<SmartLightingPreview> createState() => _SmartLightingPreviewState();
}

class _SmartLightingPreviewState extends State<SmartLightingPreview> {
  static const int numStars = 30;
  late List<bool> starStates;
  Timer? _timer;
  String _currentAnimation = "Blink";

  @override
  void initState() {
    super.initState();
    starStates = List.generate(numStars, (index) => true);
    startBlinking();
  }

  void startBlinking() {
    _stopAnimation();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        for (int i = 0; i < numStars; i++) {
          starStates[i] = !starStates[i];
        }
      });
    });
  }

  void startChasing() {
    _stopAnimation();
    int activeIndex = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        starStates = List.generate(numStars, (index) => index == activeIndex);
        activeIndex = (activeIndex + 1) % numStars;
      });
    });
  }

  void _stopAnimation() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _stopAnimation();
    super.dispose();
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton("Blink", Icons.lightbulb, startBlinking),
        _buildButton("Chase", Icons.rocket, startChasing),
      ],
    );
  }

  Widget _buildButton(String label, IconData icon, VoidCallback onPressed, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: () {
          setState(() => _currentAnimation = label);
          onPressed();
        },
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color ?? Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildStarRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numStars, (index) {
        return Text(
          "*",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: starStates[index] ? Colors.yellow : Colors.grey,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Smart Lighting Preview"),
          const SizedBox(height: 20),
          _buildStarRow(),
          const SizedBox(height: 20),
          _buildControlButtons(),
        ],
      ),
    );
  }
}