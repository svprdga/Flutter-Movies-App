import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required String id,
    required String title,
    String? imageUrl,
    required DateTime releaseDate,
  }) = _Movie;
}
