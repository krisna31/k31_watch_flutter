import 'package:equatable/equatable.dart';
import 'package:k31_watch_flutter/domain/entities/genre.dart';

// ignore: must_be_immutable
class DetailTvSeries extends Equatable {
//   {
//     "adult": false,
//     "backdrop_path": "/j8PrRaUPI19b1ZxsXaT03bQpjWm.jpg",
//     "created_by": [],
//     "episode_run_time": [
//         60
//     ],
//     "first_air_date": "2004-01-12",
//     "genres": [
//         {
//             "id": 18,
//             "name": "Drama"
//         }
//     ],
//     "homepage": "https://fujitv.co.jp/b_hp/m9_pride",
//     "id": 1,
//     "in_production": false,
//     "languages": [
//         "ja"
//     ],
//     "last_air_date": "2004-03-22",
//     "last_episode_to_air": {
//         "id": 1130472,
//         "name": "Pride Called Love",
//         "overview": "",
//         "vote_average": 0.0,
//         "vote_count": 0,
//         "air_date": "2004-03-22",
//         "episode_number": 11,
//         "episode_type": "finale",
//         "production_code": "",
//         "runtime": 60,
//         "season_number": 1,
//         "show_id": 1,
//         "still_path": null
//     },
//     "name": "Pride",
//     "next_episode_to_air": null,
//     "networks": [
//         {
//             "id": 1,
//             "logo_path": "/yS5UJjsSdZXML0YikWTYYHLPKhQ.png",
//             "name": "Fuji TV",
//             "origin_country": "JP"
//         }
//     ],
//     "number_of_episodes": 11,
//     "number_of_seasons": 1,
//     "origin_country": [
//         "JP"
//     ],
//     "original_language": "ja",
//     "original_name": "プライド",
//     "overview": "Haru Satonaka is the captain of an ice-hockey team, a star athlete who stakes everything on hockey but can only consider love as a game. Aki Murase is a woman who has been waiting for her lover who went abroad two years ago. These two persons start a relationship while frankly admitting to each other that it is only a love game. …The result is the unfolding of a drama of people with their respective pasts and with their pride as individuals.",
//     "popularity": 25.0,
//     "poster_path": "/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg",
//     "production_companies": [],
//     "production_countries": [
//         {
//             "iso_3166_1": "JP",
//             "name": "Japan"
//         }
//     ],
//     "seasons": [
//         {
//             "air_date": "2004-01-12",
//             "episode_count": 11,
//             "id": 2328126,
//             "name": "Season 1",
//             "overview": "",
//             "poster_path": "/96Cwc5ejUAiH6iAA6xOp96dkSZS.jpg",
//             "season_number": 1,
//             "vote_average": 9.0
//         }
//     ],
//     "spoken_languages": [
//         {
//             "english_name": "Japanese",
//             "iso_639_1": "ja",
//             "name": "日本語"
//         }
//     ],
//     "status": "Ended",
//     "tagline": "",
//     "type": "Scripted",
//     "vote_average": 8.2,
//     "vote_count": 13
//  }

  bool? adult;
  String? backdropPath;
  List<int>? episodeRunTime;
  String? firstAirDate;
  List<Genre>? genres;
  String? homepage;
  int id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  // LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  dynamic nextEpisodeToAir;
  // List<Networks>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  // List<ProductionCompanies>? productionCompanies;
  // List<ProductionCountries>? productionCountries;
  // List<Seasons>? seasons;
  // List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  DetailTvSeries({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    // required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    // required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    // required this.productionCompanies,
    // required this.productionCountries,
    // required this.seasons,
    // required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,
        nextEpisodeToAir,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
