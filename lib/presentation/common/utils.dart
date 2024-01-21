import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/presentation/widgets/movie_list_widget.dart';

Widget showMovieCardLogic(RequestState state, List<Movie> data) {
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
