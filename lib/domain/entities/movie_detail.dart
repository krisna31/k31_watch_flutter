import 'package:equatable/equatable.dart';
import 'package:k31_watch_flutter/domain/entities/genre.dart';
class MovieDetail extends Equatable {
  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final String title;
  final int voteCount;
  final double voteAverage;

  
  const MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteCount,
    required this.voteAverage,
  });
  
  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        originalLanguage,
        originalTitle,
        overview,
        posterPath,
        releaseDate,
        title,
        voteCount,
        voteAverage,
      ];
}
