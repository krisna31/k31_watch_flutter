import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/popular_movie_bloc.dart';
import 'package:k31_watch_flutter/presentation/widgets/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/popular-movie';
  const PopularMoviesPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PopularMovieBloc>()..add(FetchPopularMovieFromBloc()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
          builder: (context, state) {
            switch (state) {
              case PopularMovieLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PopularMovieHasData():
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.movies.length,
                );
              case PopularMovieError():
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.message),
                );
              default:
                return const Center(
                  key: Key('error_message'),
                  child: Text("Something went wrong"),
                );
            }
          },
        ),
      ),
    );
  }
}
