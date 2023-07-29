import 'package:flutter/material.dart';
import 'package:flutter_movies_app/domain/model/movie.dart';
import 'package:flutter_movies_app/presentation/detail/movie_detail_screen.dart';
import 'package:flutter_movies_app/presentation/list/movie_preview.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MoviePreview -', () {
    final movieWithImage = Movie(
      id: 'fake_id',
      title: 'fake_title',
      releaseDate: DateTime(1990, 10, 20),
      imageUrl: 'fake_image_url',
    );

    final movieWithoutImage = Movie(
      id: 'fake_id',
      title: 'fake_title',
      releaseDate: DateTime(1990, 10, 20),
    );

    Widget buildTestableWidget(Widget widget) {
      return MaterialApp(
        home: widget,
      );
    }

    group('when widget is shown', () {
      group('given Move has an image', () {
        testWidgets('should show the image', (WidgetTester tester) async {
          const key = Key('image_key');
          await tester.pumpWidget(
            buildTestableWidget(
              MoviePreview(
                movie: movieWithImage,
                imageKey: key,
              ),
            ),
          );
          final finder = find.byKey(key);
          expect(finder, findsOneWidget);
        });
      });

      group('given Move has no image', () {
        testWidgets('should not show the image container',
            (WidgetTester tester) async {
          const key = Key('image_key');
          await tester.pumpWidget(
            buildTestableWidget(
              MoviePreview(
                movie: movieWithoutImage,
                imageKey: key,
              ),
            ),
          );
          final finder = find.byKey(key);
          expect(finder, findsNothing);
        });
      });

      testWidgets('should show the Movie title', (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            MoviePreview(
              movie: movieWithoutImage,
            ),
          ),
        );
        final finder = find.text(movieWithoutImage.title);
        expect(finder, findsOneWidget);
      });

      testWidgets('should show the Movie release date',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            MoviePreview(
              movie: movieWithoutImage,
            ),
          ),
        );
        final finder = find.text('Oct 20, 1990');
        expect(finder, findsOneWidget);
      });
    });

    group('when tap on the widget', () {
      testWidgets('should navigate to MovieDetailScreen',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          buildTestableWidget(
            MoviePreview(
              movie: movieWithoutImage,
            ),
          ),
        );
        final finder = find.byType(GestureDetector);
        await tester.tap(finder);
        await tester.pumpAndSettle();

        expect(find.byType(MovieDetailScreen), findsOneWidget);
      });
    });
  });
}
