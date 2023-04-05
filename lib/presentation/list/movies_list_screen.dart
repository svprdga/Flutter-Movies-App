import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/repository/movies_repository.dart';
import 'package:flutter_movies_app/domain/model/movie.dart';
import 'package:flutter_movies_app/domain/service/app_service.dart';
import 'package:flutter_movies_app/presentation/list/movie_preview.dart';
import 'package:flutter_movies_app/presentation/list/movies_list_model.dart';
import 'package:flutter_movies_app/util/l10n/app_localizations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class MoviesListScreen extends StatefulWidget {
  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  late final AppService _appService;

  late final MoviesListModel _model;
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);
  late final Future<void> _future;

  @override
  void initState() {
    super.initState();

    _appService = Provider.of<AppService>(context, listen: false);

    _model = MoviesListModel(
      log: Provider.of<Logger>(context, listen: false),
      moviesRepo: Provider.of<MoviesRepository>(context, listen: false),
    );

    _future = _checkNewData();

    _pagingController.addPageRequestListener((pageKey) async {
      try {
        final movies = await _model.fetchPage(pageKey);
        _pagingController.appendPage(movies, pageKey + 1);
      } catch (e) {
        _pagingController.error = e;
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).upcomingMovies),
        actions: [
          IconButton(
            onPressed: () {
              _appService.themeMode = _appService.themeMode == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
            tooltip: AppLocalizations.of(context).toggleLightDart,
            icon: Icon(
              _appService.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _future,
        builder: (context, snapshot) => RefreshIndicator(
          onRefresh: _refresh,
          child: PagedListView<int, Movie>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Movie>(
              itemBuilder: (context, movie, index) => Container(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  top: 6.0,
                  right: 12.0,
                  bottom: 6.0,
                ),
                child: MoviePreview(movie: movie),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    await _model.deletePersistedMovies();
    _pagingController.refresh();
  }

  Future<void> _checkNewData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final appLocalizations = AppLocalizations.of(context);
      final hasNewData = await _model.hasNewData();

      if (hasNewData) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(appLocalizations.getNewData),
            action: SnackBarAction(
              label: appLocalizations.refresh,
              onPressed: _refresh,
            ),
          ),
        );
      }
    });
  }
}
