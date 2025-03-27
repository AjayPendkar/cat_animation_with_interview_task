# Cat Animation with Interview Task

A Flutter application showcasing an interactive cat animation with theme management and localization support. This project demonstrates clean architecture principles using BLoC pattern.

## Features

- 🐱 Custom animated cat with:
  - Smooth tail wave animation
  - Interactive ear movements
  - Clean, modern design

- 🎨 Theme Management:
  - Light/Dark theme support
  - Persistent theme preferences
  - Smooth theme transitions

- 🌍 Localization:
  - English and Spanish support
  - Easy to add more languages
  - Persistent language preferences

- 🏗 Clean Architecture:
  - BLoC pattern implementation
  - Separation of concerns
  - Maintainable and scalable code

## Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Dart SDK (latest version)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/AjayPendkar/cat_animation_with_interview_task.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── theme_bloc.dart
│   └── localization/
│       ├── app_localizations.dart
│       └── localization_bloc.dart
├── features/
│   └── cat_animation/
│       ├── presentation/
│       │   ├── pages/
│       │   └── widgets/
│       ├── domain/
│       └── data/
└── main.dart
```

