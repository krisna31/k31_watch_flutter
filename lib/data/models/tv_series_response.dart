import 'package:equatable/equatable.dart';
import 'package:k31_watch_flutter/data/models/tv_series_model.dart';

class TvSeriesResponse extends Equatable {
  const TvSeriesResponse({required this.tvSeriesList});
  final List<TvSeriesModel> tvSeriesList;
  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
        tvSeriesList: List<TvSeriesModel>.from((json["results"] as List)
              .map(
                (x) => TvSeriesModel.fromJson(x),
              )
            .where(
                (element) =>
                    element.posterPath != null || element.backdropPath != null,
              ),
        ),
      );
  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
      };
  @override
  List<Object> get props => [tvSeriesList];
}
