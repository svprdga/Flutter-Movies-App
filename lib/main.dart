import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movies_app/data/database/dao/movies_dao.dart';
import 'package:flutter_movies_app/data/database/database_mapper.dart';
import 'package:flutter_movies_app/data/datasource/preferences.dart';
import 'package:flutter_movies_app/data/network/client/api_client.dart';
import 'package:flutter_movies_app/data/network/network_mapper.dart';
import 'package:flutter_movies_app/data/repository/movies_repository.dart';
import 'package:flutter_movies_app/data/repository/preferences_repository.dart';
import 'package:flutter_movies_app/domain/model/config.dart';
import 'package:flutter_movies_app/domain/service/app_service.dart';
import 'package:flutter_movies_app/presentation/app/app.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class InitialData {
  final List<SingleChildWidget> providers;

  InitialData({required this.providers});
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ignore: avoid_redundant_argument_values,  deprecated_member_use
  await Sqflite.devSetDebugModeOn(kDebugMode);

  final data = await _createData();

  runApp(App(data: data));
}

Future<InitialData> _createData() async {
  // Util
  final log = Logger(
    printer: PrettyPrinter(),
    level: kDebugMode ? Level.trace : Level.off,
  );

  // Load project configuration
  final config = await _loadConfig(log);

  // Data
  final apiClient = ApiClient(
    baseUrl: 'https://moviesdatabase.p.rapidapi.com/',
    apiKey: config.apiKey,
    apiHost: config.apiHost,
  );
  final networkMapper = NetworkMapper(log: log);
  final moviesDao = MoviesDao();
  final databaseMapper = DatabaseMapper(log: log);
  final moviesRepository = MoviesRepository(
    apiClient: apiClient,
    networkMapper: networkMapper,
    moviesDao: moviesDao,
    databaseMapper: databaseMapper,
  );

  final preferences = Preferences(prefs: await SharedPreferences.getInstance());
  final preferencesRepo = PreferencesRepository(preferences: preferences);

  // Services
  final appService = AppService(preferencesRepo: preferencesRepo);
  await appService.load();

  // Create list of providers
  return InitialData(
    providers: [
      Provider<Logger>.value(value: log),
      Provider<MoviesRepository>.value(value: moviesRepository),
      ChangeNotifierProvider<AppService>.value(value: appService)
    ],
  );
}

Future<Config> _loadConfig(Logger log) async {
  String raw;

  try {
    raw = await rootBundle.loadString('assets/config/config.json');

    final config = json.decode(raw) as Map<String, dynamic>;

    return Config(
      apiKey: config['apiKey'] as String,
      apiHost: config['apiHost'] as String,
    );
  } catch (e) {
    log.e(
      'Error while loading project configuration, please make sure '
      'that the file located at /assets/config/config.json '
      'exists and that it contains the correct configuration.',
      error: e,
    );
    rethrow;
  }
}
