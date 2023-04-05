import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'App de Películas';

  @override
  String get toggleLightDart => 'Intercambiar modo claro/oscuro';

  @override
  String get upcomingMovies => 'Próximas películas';

  @override
  String get refresh => 'Refrescar';

  @override
  String get getNewData => 'Refrescar para obtener datos nuevos';
}
