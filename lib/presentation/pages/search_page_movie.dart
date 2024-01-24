import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/presentation/bloc/search_movie_bloc.dart';
import 'package:k31_watch_flutter/presentation/widgets/movie_card_list.dart';

class SearchPageMovie extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/search-movies';

  const SearchPageMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) => context
                  .read<SearchMovieBloc>()
                  .add(QuerySearchMovieFromBloc(query)),
              decoration: const InputDecoration(
                hintText: 'Search title movie',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: myTextTheme.titleLarge,
            ),
            BlocBuilder<SearchMovieBloc, SearchMovieState>(
              builder: (context, state) {
                switch (state) {
                  case SearchMovieLoading():
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case SearchMovieHasData():
                    return ShowWidgetResultMovie(result: state.result);
                  case SearchMovieError():
                    return Center(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  default:
                    return Expanded(
                      child: Container(),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShowWidgetResultMovie extends StatelessWidget {
  const ShowWidgetResultMovie({
    super.key,
    required this.result,
  });

  final List<Movie> result;

  @override
  Widget build(BuildContext context) {
    if (result.isEmpty) {
      return const Center(
        child: Text('No Result Founded'),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) => MovieCard(result[index]),
        itemCount: result.length,
      ),
    );
  }
}
