import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TvSeries extends Equatable {
  // {
  //     "adult": false,
  //     "backdrop_path": "/lG2RqipaTNF1CRjlmpmqsnebmaY.jpg",
  //     "genre_ids": [
  //       9648,
  //       10762,
  //       18
  //     ],
  //     "id": 229501,
  //     "origin_country": [
  //       "SE"
  //     ],
  //     "original_language": "sv",
  //     "original_name": "12:13",
  //     "overview": "Every noon at exactly 12:13 a mysterious Instagram account post embarrassing photos about the students at Solængsskolen.",
  //     "popularity": 2262.772,
  //     "poster_path": null,
  //     "first_air_date": "2020-08-06",
  //     "name": "12:13",
  //     "vote_average": 6.0,
  //     "vote_count": 1
  //   }
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;

  TvSeries({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  TvSeries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
      ];
}
