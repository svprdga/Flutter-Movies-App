# Flutter Movies App

This is a sample Flutter project demonstrating different best practices on how to build a hybrid app for Android and iOS.

## How to build the project

This app uses an API to get a list of the latest movies, you can see the details of said API in the following [link](https://rapidapi.com/SAdrian/api/moviesdatabase/). 

Follow these steps to be able to build the project:

1. Sign up at the link provided
2. Copy the file located in `/assets/config/config.json.temp` and rename it to `config.json`
3. Replace the `apiKey` and `apiHost` values with those provided when registering to this API

Once this is done, the app should be able to run on both Android and iOS (including emulators and simulators).

## What is included in this example

- Clean architecture: this example tries to reproduce the basic SOLID principles, without being completely strict with the basic principles of clean architecture; it's about getting a good trade-off between robustness, agility, scalability, and maintainability.
- Database persistence: it can be seen that the movie data obtained from the API is persisted in a local database in order to offer an interface with content to the user once the application is opened, in addition to saving bandwidth. A system is also included to be able to notify the user in the event that new data is detected, provided that such data can be obtained.
- The [provider](https://pub.dev/packages/provider) library is used as state management.
- The app can toggle between light and dark theme, in addition, this choice persists between sessions.
- For model management, we have chosen to use [freezed](https://pub.dev/packages/freezed), as it provides an assortment of methods and utilities that perfectly complement the Dart classes. In addition, [json_serializable](https://pub.dev/packages/json_serializable) is used for the data layer models to speed up their creation and maintenance.
- Unit test: a small sample on how to implement a unit test has been added. This file can be found in the `test` directory and can be run with `flutter test`.

## Additional Information

The domain and data layer models can be generated with the following command:

`flutter pub run build_runner build --delete-conflicting-outputs`

Translation files can also be generated with:

`flutter gen-l10n --arb-dir=assets/l10n --template-arb-file=strings_en.arb --output-localization-file=app_localizations.dart --output-class=AppLocalizations --output-dir=lib/util/l10n --no-synthetic-package`