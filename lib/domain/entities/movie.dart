
import 'package:equatable/equatable.dart';
// ignore: must_be_immutable
class Movie extends Equatable {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  int? voteCount;
  double? voteAverage;
  
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteCount,
    required this.voteAverage,
  });

  Movie.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
  });
  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteCount,
        voteAverage,
      ];
}
