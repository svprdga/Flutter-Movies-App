import 'package:json_annotation/json_annotation.dart';

part 'movie_db_entity.g.dart';

@JsonSerializable()
class MovieDbEntity {
  static const fieldId = 'movie_id';
  static const fieldMovieId = 'movie_movie_id';
  static const fieldTitle = 'movie_title';
  static const fieldImageUrl = 'movie_image_url';
  static const fieldReleaseDate = 'movie_release_date';

  @JsonKey(name: fieldId)
  final int? id;
  @JsonKey(name: fieldMovieId)
  final String movieId;
  @JsonKey(name: fieldTitle)
  final String title;
  @JsonKey(name: fieldImageUrl)
  final String? imageUrl;
  @JsonKey(name: fieldReleaseDate)
  final int releaseDate;

  MovieDbEntity({
    required this.id,
    required this.movieId,
    required this.title,
    this.imageUrl,
    required this.releaseDate,
  });

  factory MovieDbEntity.fromJson(Map<String, dynamic> json) =>
      _$MovieDbEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDbEntityToJson(this);
}
