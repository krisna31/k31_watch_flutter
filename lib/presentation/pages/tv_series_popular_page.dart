import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_popular_notifier.dart';
import 'package:provider/provider.dart';

import 'package:k31_watch_flutter/presentation/widgets/tv_series_list_widget.dart';

import 'package:flutter/material.dart';

class TvSeriesPopularPage extends StatefulWidget {
  const TvSeriesPopularPage({super.key});

  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  // ignore: library_private_types_in_public_api
  _TvSeriesPopularPageState createState() => _TvSeriesPopularPageState();
}

class _TvSeriesPopularPageState extends State<TvSeriesPopularPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TvSeriesPopularNotifier>(context, listen: false)
        ..fetchPopularTvSeriesFromNotifier(),
    );
  }

  Widget showTvSeriesListWidgetLogic(TvSeriesPopularNotifier data) {
    if (data.popularTvSeriesState == RequestState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (data.popularTvSeriesState == RequestState.loaded) {
      return ListView.builder(
        itemBuilder: (context, index) {
          // return MovieCard(data.popularTvSeries[index]);
          var tvData = data.popularTvSeries[index];
          return TvSeriesListWidget(tvData: tvData);
        },
        itemCount: data.popularTvSeries.length,
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
      appBar: _buildAppBarTvSeriesPopular(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvSeriesPopularNotifier>(
          builder: (context, data, child) {
            return showTvSeriesListWidgetLogic(data);
          },
        ),
      ),
    );
  }

  AppBar _buildAppBarTvSeriesPopular() {
    return AppBar(
      title: const Text('Popular Tv Series'),
    );
  }
}
