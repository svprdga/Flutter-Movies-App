import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_movies_app/domain/service/app_service.dart';
import 'package:flutter_movies_app/main.dart';
import 'package:flutter_movies_app/presentation/list/movies_list_screen.dart';
import 'package:flutter_movies_app/util/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final InitialData data;

  const App({required this.data});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: data.providers,
      child: Consumer<AppService>(
        builder: (context, service, child) => MaterialApp(
          title: 'Movies App',
          theme: ThemeData(
            primarySwatch: Colors.green,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.green,
            brightness: Brightness.dark,
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
            ),
          ),
          themeMode: service.themeMode,
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: MoviesListScreen(),
        ),
      ),
    );
  }
}
