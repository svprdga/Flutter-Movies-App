import 'package:flutter/material.dart';
import 'package:flutter_movies_app/data/datasource/preferences.dart';
import 'package:flutter_movies_app/data/repository/preferences_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  group('PreferencesRepository -', () {
    late PreferencesRepository preferencesRepo;

    late Preferences preferences;

    setUp(() {
      preferences = PreferencesMock();

      when(() => preferences.setThemeMode(any()))
          .thenAnswer((invocation) => Future.value());

      preferencesRepo = PreferencesRepository(preferences: preferences);
    });

    group('when calling setThemeMode()', () {
      group('given ThemeMode is system', () {
        test("should save the 'system' value of ThemeMode", () async {
          await preferencesRepo.setThemeMode(ThemeMode.system);
          final captured =
              verify(() => preferences.setThemeMode(captureAny())).captured;
          expect(captured[0], ThemeMode.system.index);
        });
      });

      group('given ThemeMode is light', () {
        test("should save the 'light' value of ThemeMode", () async {
          await preferencesRepo.setThemeMode(ThemeMode.light);
          final captured =
              verify(() => preferences.setThemeMode(captureAny())).captured;
          expect(captured[0], ThemeMode.light.index);
        });
      });

      group('given ThemeMode is dark', () {
        test("should save the 'system' value of ThemeMode", () async {
          await preferencesRepo.setThemeMode(ThemeMode.dark);
          final captured =
              verify(() => preferences.setThemeMode(captureAny())).captured;
          expect(captured[0], ThemeMode.dark.index);
        });
      });
    });

    group('when calling getThemeMode()', () {
      group('given saved parameter is light', () {
        test('should return ThemeMode.light value', () async {
          when(() => preferences.getThemeMode())
              .thenAnswer((_) => Future.value(ThemeMode.light.index));
          final result = await preferencesRepo.getThemeMode();
          expect(result, ThemeMode.light);
        });
      });

      group('given saved parameter is dark', () {
        test('should return ThemeMode.dark value', () async {
          when(() => preferences.getThemeMode())
              .thenAnswer((_) => Future.value(ThemeMode.dark.index));
          final result = await preferencesRepo.getThemeMode();
          expect(result, ThemeMode.dark);
        });
      });
    });
  });
}
