import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/presentation/bloc/search_tv_series_bloc.dart';
import 'package:k31_watch_flutter/presentation/widgets/tv_series_list_widget.dart';

class SearchPageTv extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/search=tv-series';

  const SearchPageTv({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv SEries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              // onSubmitted: (query) {
              //   Provider.of<SearchTvNotifier>(context, listen: false)
              //       .fetchTvSearchFromNotifier(query);
              // },
              onChanged: (query) {
                context.read<SearchTvSeriesBloc>().add(OnQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'S earch title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result Tv Series',
              style: myTextTheme.titleLarge,
            ),
            BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
              builder: (context, state) {
                switch (state) {
                  case SearchTvLoading():
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case SearchTvHasData():
                    return ShowTvSeriesCardResult(result: state.result);
                  case SearchTvError():
                    return Center(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  default:
                    return Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text('Search your favorite tv series'),
                      ),
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

class ShowTvSeriesCardResult extends StatelessWidget {
  const ShowTvSeriesCardResult({
    super.key,
    required this.result,
  });

  final List<TvSeries> result;

  @override
  Widget build(BuildContext context) {
    if (result.isEmpty) {
      return Expanded(
        child: Container(
          alignment: Alignment.center,
          child: const Text('No result found'),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final tv = result[index];
          return TvSeriesListWidget(
            tvData: tv,
          );
        },
        itemCount: result.length,
      ),
    );
  }
}
