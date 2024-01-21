import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/presentation/providers/top_rated_movie_notifier.dart';
import 'package:k31_watch_flutter/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/top-rated-tv-series';

  const TopRatedTvSeriesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TopRatedTvSeriesPageState createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedMoviesNotifier>(context, listen: false)
            .fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Consumer<TopRatedMoviesNotifier>(
      //     builder: (context, data, child) {
      //       if (data.state == RequestState.loading) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       } else if (data.state == RequestState.loaded) {
      //         return ListView.builder(
      //           itemBuilder: (context, index) {
      //             final movie = data.movies[index];
      //             return MovieCard(movie);
      //           },
      //           itemCount: data.movies.length,
      //         );
      //       } else {
      //         return Center(
      //           key: const Key('error_message'),
      //           child: Text(data.message),
      //         );
      //       }
      //     },
      //   ),
      // ),
    );
  }
}
