import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/presentation/providers/popular_movie.notifier.dart';
import 'package:k31_watch_flutter/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

class PopularTvSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/popular-tv-series';

  const PopularTvSeriesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PopularTvSeriesPageState createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularMoviesNotifier>(context, listen: false)
            .fetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Consumer<PopularMoviesNotifier>(
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
