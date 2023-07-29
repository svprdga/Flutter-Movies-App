import 'package:flutter_movies_app/data/database/dao/movies_dao.dart';
import 'package:flutter_movies_app/data/database/database_mapper.dart';
import 'package:flutter_movies_app/data/datasource/preferences.dart';
import 'package:flutter_movies_app/data/network/client/api_client.dart';
import 'package:flutter_movies_app/data/network/network_mapper.dart';
import 'package:mocktail/mocktail.dart';

class ApiClientMock extends Mock implements ApiClient {}

class NetworkMapperMock extends Mock implements NetworkMapper {}

class MoviesDaoMock extends Mock implements MoviesDao {}

class DatabaseMapperMock extends Mock implements DatabaseMapper {}

class PreferencesMock extends Mock implements Preferences {}
