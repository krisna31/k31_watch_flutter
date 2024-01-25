import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/popular_movie_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:k31_watch_flutter/presentation/pages/popular_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/presentation/pages/search_page_movie.dart';
import 'package:k31_watch_flutter/presentation/pages/top_rated_movie_page.dart';
import 'package:k31_watch_flutter/presentation/widgets/movie_list_widget.dart';
import 'package:k31_watch_flutter/presentation/widgets/my_drawer.dart';
import 'package:k31_watch_flutter/presentation/widgets/subtitle_widget.dart';

class MoviePage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/movie-page';
  const MoviePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () {
      context.read<NowPlayingMovieBloc>().add(
            FetchNowPlayingMovieFromBloc(),
          );

      context.read<PopularMovieBloc>().add(
            FetchPopularMovieFromBloc(),
          );

      context.read<TopRatedMovieBloc>().add(
            FetchTopRatedMovieFromBloc(),
          );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              SearchPageMovie.ROUTE_NAME,
            ),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Now Playing', style: myTextTheme.bodyMedium),
              BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
                builder: (context, state) => _showNowPlayMovieCardLogic(state),
              ),
              SubtitleWidget(
                title: "Popular",
                onTapFunction: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMovieBloc, PopularMovieState>(
                  builder: (context, state) {
                switch (state) {
                  case PopularMovieLoading():
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case PopularMovieHasData():
                    return MovieListWidget(state.movies);
                  case PopularMovieError():
                    return Center(
                      key: const Key('error_message_formm_bloc'),
                      child: Text(state.message),
                    );
                  default:
                    return const Text('Failed');
                }
              }
              ),
              SubtitleWidget(
                title: "Top Rated",
                onTapFunction: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                builder: (context, state) {
                  switch (state) {
                    case TopRatedMovieLoading():
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case TopRatedMovieHasData():
                      return MovieListWidget(state.movies);
                    case TopRatedMovieError():
                      return Center(
                        key: const Key('error_message_formm_bloc'),
                        child: Text(state.message),
                      );
                    default:
                      return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showNowPlayMovieCardLogic(NowPlayingMovieState state) {
    switch (state) {
      case NowPlayingMovieLoading():
        return const Center(
          child: CircularProgressIndicator(),
        );
      case NowPlayingMovieHasData():
        return MovieListWidget(state.movies);
      case NowPlayingMovieError():
        return Center(
          key: const Key('error_message_formm_bloc'),
          child: Text(state.message),
        );
      default:
        return const Text('Failed');
    }
  }
}
