import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_entity.g.dart';

@JsonSerializable()
class UpcomingMovies {
  UpcomingMovies({
    required this.next,
    required this.entries,
    required this.results,
  });

  String next;
  int entries;
  List<MovieEntity> results;

  factory UpcomingMovies.fromJson(Map<String, dynamic> json) =>
      _$UpcomingMoviesFromJson(json);
}

@JsonSerializable()
class MovieEntity {
  MovieEntity({
    required this.id,
    this.primaryImage,
    required this.titleType,
    required this.titleText,
    this.releaseYear,
    required this.releaseDate,
  });

  String id;
  PrimaryImage? primaryImage;
  TitleType titleType;
  TitleText titleText;
  ReleaseYear? releaseYear;
  ReleaseDate releaseDate;

  factory MovieEntity.fromJson(Map<String, dynamic> json) =>
      _$MovieEntityFromJson(json);
}

@JsonSerializable()
class PrimaryImage {
  PrimaryImage({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.caption,
  });

  String id;
  int width;
  int height;
  String url;
  Caption caption;

  factory PrimaryImage.fromJson(Map<String, dynamic> json) =>
      _$PrimaryImageFromJson(json);
}

@JsonSerializable()
class Caption {
  Caption({
    required this.plainText,
  });

  String plainText;

  factory Caption.fromJson(Map<String, dynamic> json) =>
      _$CaptionFromJson(json);
}

@JsonSerializable()
class ReleaseDate {
  ReleaseDate({
    required this.day,
    required this.month,
    required this.year,
  });

  int day;
  int month;
  int year;

  factory ReleaseDate.fromJson(Map<String, dynamic> json) =>
      _$ReleaseDateFromJson(json);
}

@JsonSerializable()
class ReleaseYear {
  ReleaseYear({
    required this.year,
    this.endYear,
  });

  int year;
  dynamic endYear;

  factory ReleaseYear.fromJson(Map<String, dynamic> json) =>
      _$ReleaseYearFromJson(json);
}

@JsonSerializable()
class TitleText {
  TitleText({
    required this.text,
  });

  String text;

  factory TitleText.fromJson(Map<String, dynamic> json) =>
      _$TitleTextFromJson(json);
}

@JsonSerializable()
class TitleType {
  TitleType({
    required this.text,
    required this.id,
    required this.isSeries,
    required this.isEpisode,
    this.categories,
    this.canHaveEpisodes,
  });

  String text;
  String id;
  bool isSeries;
  bool isEpisode;
  List<Category>? categories;
  bool? canHaveEpisodes;

  factory TitleType.fromJson(Map<String, dynamic> json) =>
      _$TitleTypeFromJson(json);
}

@JsonSerializable()
class Category {
  Category({
    required this.value,
  });

  String value;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
