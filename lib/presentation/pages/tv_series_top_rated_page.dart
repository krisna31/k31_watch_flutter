import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_top_rated_notifier.dart';
import 'package:provider/provider.dart';

import 'package:k31_watch_flutter/presentation/widgets/tv_series_list_widget.dart';

import 'package:flutter/material.dart';

class TvSeriesTopRatedPage extends StatefulWidget {
  const TvSeriesTopRatedPage({super.key});

  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  // ignore: library_private_types_in_public_api
  _TvSeriesTopRatedPageState createState() => _TvSeriesTopRatedPageState();
}

class _TvSeriesTopRatedPageState extends State<TvSeriesTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TvSeriesTopRatedNotifier>(context, listen: false)
        ..fetchTopRatedTvSeriesFromNotifier(),
    );
  }

  AppBar _buildAppBarTvSeriesTopRated() {
    return AppBar(
      title: const Text('Top Rated TV Series'),
    );
  }

  Widget showTvSeriesListWidgetLogic(TvSeriesTopRatedNotifier data) {
    if (data.topRatedTvSeriesState == RequestState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (data.topRatedTvSeriesState == RequestState.loaded) {
      return ListView.builder(
        itemBuilder: (context, index) {
          // return MovieCard(data.popularTvSeries[index]);
          var tvData = data.topRatedTvSeries[index];
          return TvSeriesListWidget(tvData: tvData);
        },
        itemCount: data.topRatedTvSeries.length,
      );
    } else {
      return Center(
        key: const Key('error_message'),
        child: Text(data.message),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarTvSeriesTopRated(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvSeriesTopRatedNotifier>(
          builder: (context, data, child) {
            return showTvSeriesListWidgetLogic(data);
          },
        ),
      ),
    );
  }
}
