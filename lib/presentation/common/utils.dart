import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/presentation/widgets/movie_list_widget.dart';
import 'package:k31_watch_flutter/presentation/widgets/tv_series_list.dart';

Widget showMovieCardLogic(state, List<Movie> data) {
  switch (state) {
    case RequestState.loading:
      return const Center(
        child: CircularProgressIndicator(),
      );
    case RequestState.loaded:
      return MovieListWidget(data);
    default:
      return const Text('Failed');
  }
}

Widget showTvSeriesCardLogic(RequestState state, List<TvSeries> data) {
  switch (state) {
    case RequestState.loading:
      return const Center(
        child: CircularProgressIndicator(),
      );
    case RequestState.loaded:
      return TvSeriesList(data);
    default:
      return const Text('Failed');
  }
}


