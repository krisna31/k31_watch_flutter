import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/presentation/providers/movie_search_notifier.dart';
import 'package:k31_watch_flutter/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

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
              onSubmitted: (query) {
                Provider.of<MovieSearchNotifier>(context, listen: false)
                    .fetchMovieSearch(query);
              },
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
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                switch (data.state) {
                  case RequestState.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case RequestState.loaded:
                    final result = data.searchResult;
                    return ShowWidgetResultMovie(result: result);
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
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) => MovieCard(result[index]),
        itemCount: result.length,
      ),
    );
  }
}