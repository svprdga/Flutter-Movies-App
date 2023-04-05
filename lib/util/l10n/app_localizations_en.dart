import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Movies App';

  @override
  String get toggleLightDart => 'Toggle light/dark mode';

  @override
  String get upcomingMovies => 'Upcoming movies';

  @override
  String get refresh => 'Refresh';

  @override
  String get getNewData => 'Refresh to fetch new data';
}
