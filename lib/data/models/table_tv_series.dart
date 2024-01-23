import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';

class TableTvSeries extends Equatable {
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;

  const TableTvSeries({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TableTvSeries.fromEntity(DetailTvSeries tv) => TableTvSeries(
        id: tv.id,
        name: tv.name,
        posterPath: tv.posterPath,
        overview: tv.overview,
      );

  factory TableTvSeries.fromMap(Map<String, dynamic> map) => TableTvSeries(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TvSeries toEntity() => TvSeries.watchlist(
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
