// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_db_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDbEntity _$MovieDbEntityFromJson(Map<String, dynamic> json) =>
    MovieDbEntity(
      id: json['movie_id'] as int?,
      movieId: json['movie_movie_id'] as String,
      title: json['movie_title'] as String,
      imageUrl: json['movie_image_url'] as String?,
      releaseDate: json['movie_release_date'] as int,
    );

Map<String, dynamic> _$MovieDbEntityToJson(MovieDbEntity instance) =>
    <String, dynamic>{
      'movie_id': instance.id,
      'movie_movie_id': instance.movieId,
      'movie_title': instance.title,
      'movie_image_url': instance.imageUrl,
      'movie_release_date': instance.releaseDate,
    };
