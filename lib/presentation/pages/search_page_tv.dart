import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/presentation/providers/search_tv_notifier.dart';
import 'package:k31_watch_flutter/presentation/widgets/tv_series_list_widget.dart';
import 'package:provider/provider.dart';

class SearchPageTv extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/search=tv-series';

  const SearchPageTv({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search  Tv SEries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<SearchTvNotifier>(context, listen: false)
                    .fetchTvSearchFromNotifier(query);
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
              'Search Result',
              style: myTextTheme.titleLarge,
            ),
            Consumer<SearchTvNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.loaded) {
                  final result = data.searchResult;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = data.searchResult[index];
                        return TvSeriesListWidget(
                          tvData: tv,
                        );
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
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