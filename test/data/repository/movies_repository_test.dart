import 'package:flutter_movies_app/data/database/dao/movies_dao.dart';
import 'package:flutter_movies_app/data/database/database_mapper.dart';
import 'package:flutter_movies_app/data/database/entity/movie_db_entity.dart';
import 'package:flutter_movies_app/data/network/client/api_client.dart';
import 'package:flutter_movies_app/data/network/entity/movie_entity.dart';
import 'package:flutter_movies_app/data/network/network_mapper.dart';
import 'package:flutter_movies_app/data/repository/movies_repository.dart';
import 'package:flutter_movies_app/domain/model/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  group('MoviesRepository -', () {
    late MoviesRepository moviesRepo;

    late ApiClient apiClient;
    late NetworkMapper networkMapper;
    late MoviesDao moviesDao;
    late DatabaseMapper databaseMapper;

    final today = DateTime.now();

    final databaseData = [
      MovieDbEntity(
        id: 0,
        movieId: 'movie_0',
        title: 'title_0',
        releaseDate: today.millisecondsSinceEpoch,
      ),
      MovieDbEntity(
        id: 1,
        movieId: 'movie_1',
        title: 'title_1',
        releaseDate: today.millisecondsSinceEpoch,
      ),
      MovieDbEntity(
        id: 2,
        movieId: 'movie_2',
        title: 'title_2',
        releaseDate: today.millisecondsSinceEpoch,
      ),
    ];

    final apiData = [
      MovieEntity(
        id: 'movie_0',
        titleType: TitleType(
          id: 'title_type_0',
          text: 'title_0',
          isSeries: false,
          isEpisode: false,
        ),
        titleText: TitleText(
          text: 'title_0',
        ),
        releaseDate:
            ReleaseDate(day: today.day, month: today.month, year: today.year),
      ),
      MovieEntity(
        id: 'movie_1',
        titleType: TitleType(
          id: 'title_type_1',
          text: 'title_1',
          isSeries: false,
          isEpisode: false,
        ),
        titleText: TitleText(
          text: 'title_1',
        ),
        releaseDate:
            ReleaseDate(day: today.day, month: today.month, year: today.year),
      ),
      MovieEntity(
        id: 'movie_2',
        titleType: TitleType(
          id: 'title_type_2',
          text: 'title_2',
          isSeries: false,
          isEpisode: false,
        ),
        titleText: TitleText(
          text: 'title_2',
        ),
        releaseDate:
            ReleaseDate(day: today.day, month: today.month, year: today.year),
      ),
    ];

    final models = [
      Movie(
        id: 'movie_0',
        title: 'title_0',
        releaseDate: today,
      ),
      Movie(
        id: 'movie_1',
        title: 'title_1',
        releaseDate: today,
      ),
      Movie(
        id: 'movie_2',
        title: 'title_2',
        releaseDate: today,
      ),
    ];

    setUp(() {
      apiClient = ApiClientMock();
      networkMapper = NetworkMapperMock();
      moviesDao = MoviesDaoMock();
      databaseMapper = DatabaseMapperMock();

      moviesRepo = MoviesRepository(
        apiClient: apiClient,
        networkMapper: networkMapper,
        moviesDao: moviesDao,
        databaseMapper: databaseMapper,
      );
    });

    group('when calling getUpcomingMovies()', () {
      group('given that database contains data', () {
        setUp(() {
          when(() => moviesDao.selectAll(limit: 10, offset: 0))
              .thenAnswer((_) => Future.value(databaseData));
          when(() => databaseMapper.toMovies(databaseData)).thenReturn(models);
        });

        test('should return database movies', () async {
          final movies = await moviesRepo.getUpcomingMovies(limit: 10, page: 1);
          expect(movies, models);
        });
      });

      group("given that database don't contains relevant data", () {
        late List<Movie> movies;

        setUp(() async {
          when(() => moviesDao.selectAll(limit: 10, offset: 0))
              .thenAnswer((_) => Future.value([]));
          when(() => apiClient.getUpcomingMovies(page: 1)).thenAnswer(
            (invocation) => Future.value(
              UpcomingMovies(
                next: 'next',
                entries: 10,
                results: apiData,
              ),
            ),
          );
          when(() => networkMapper.toMovies(apiData)).thenReturn(models);
          when(() => databaseMapper.toMovieDbEntities(models))
              .thenReturn(databaseData);
          when(() => moviesDao.insertAll(databaseData))
              .thenAnswer((_) => Future.value());

          movies = await moviesRepo.getUpcomingMovies(limit: 10, page: 1);
        });

        test('should fetch movies from remote API', () {
          final captured = verify(
            () => apiClient.getUpcomingMovies(
              page: captureAny(named: 'page'),
            ),
          ).captured;

          expect(captured.first, 1);
        });

        test('should persist fetched data to database', () {
          final captured = verify(
            () => moviesDao.insertAll(captureAny()),
          ).captured;

          expect(captured.first, databaseData);
        });

        test('should return fetched data', () {
          expect(movies, models);
        });
      });
    });
  });
}
