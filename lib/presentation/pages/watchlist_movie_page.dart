import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/common/route_observer.dart';
import 'package:k31_watch_flutter/presentation/bloc/watch_list_movie_bloc.dart';
import 'package:k31_watch_flutter/presentation/widgets/movie_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchListMovieBloc>().add(FetchWatchListMovieEvent()));
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }
  @override
  void didPopNext() {
    context.read<WatchListMovieBloc>().add(FetchWatchListMovieEvent());
  }
  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchListMovieBloc, WatchListMovieState>(
          builder: (context, data) {
            switch (data) {
              case WatchListMovieLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case WatchListMovieHasData():
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = data.movies[index];
                    return MovieCard(movie);
                  },
                  itemCount: data.movies.length,
                );
              case WatchListMovieError():
                return const Center(
                  child: Text('Error'),
                );
              default:
                return const Center(
                  child: Text('Error'),
                );
            }
          },
        ),
      ),
    );
  }
}
