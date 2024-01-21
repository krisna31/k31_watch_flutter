import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/presentation/common/utils.dart';
import 'package:k31_watch_flutter/presentation/providers/movie_list_notifier.dart';
import 'package:k31_watch_flutter/presentation/pages/popular_movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/search_page.dart';
import 'package:k31_watch_flutter/presentation/pages/top_rated_movie_page.dart';
import 'package:k31_watch_flutter/presentation/widgets/my_drawer.dart';
import 'package:k31_watch_flutter/presentation/widgets/subtitle_widget.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/movie-page';

  const HomeMoviePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MovieListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies());
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
              SearchPage.ROUTE_NAME,
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
              Consumer<MovieListNotifier>(
                builder: (context, data, child) {
                  return showMovieCardLogic(
                    data.nowPlayingState,
                    data.nowPlayingMovies,
                  );
                },
              ),
              SubtitleWidget(
                title: "Popular",
                onTapFunction: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              Consumer<MovieListNotifier>(
                builder: (context, data, child) => showMovieCardLogic(
                    data.popularMoviesState,
                    data.popularMovies,
                ),
              ),
              SubtitleWidget(
                title: "Top Rated",
                onTapFunction: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              Consumer<MovieListNotifier>(
                builder: (context, data, child) => showMovieCardLogic(
                    data.topRatedMoviesState,
                    data.topRatedMovies,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
