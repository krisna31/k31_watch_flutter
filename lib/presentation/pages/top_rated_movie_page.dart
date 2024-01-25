import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:k31_watch_flutter/presentation/widgets/movie_card_list.dart';

class TopRatedMoviesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/top-rated-movie';

  const TopRatedMoviesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TopRatedMovieBloc>().add(
          FetchTopRatedMovieFromBloc(),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
          builder: (context, state) {
            switch (state) {
              case TopRatedMovieLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case TopRatedMovieHasData():
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.movies.length,
                );
              case TopRatedMovieError():
                return Center(
                  key: const Key('error_message_formm_bloc'),
                  child: Text(state.message),
                );
              default:
                return const Center(
                  key: Key('error_message'),
                  child: Text("SOmething went wrong"),
                );
            }
          },
        ),
      ),
    );
  }
}
