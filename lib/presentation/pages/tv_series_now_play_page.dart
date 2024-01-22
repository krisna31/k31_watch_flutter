import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_now_play_notifier.dart';
import 'package:provider/provider.dart';

import 'package:k31_watch_flutter/presentation/widgets/tv_series_list_widget.dart';

import 'package:flutter/material.dart';

class TvSeriesNowPlayPage extends StatefulWidget {
  const TvSeriesNowPlayPage({super.key});

  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/now-play-tv-series';

  @override
  // ignore: library_private_types_in_public_api
  _TvSeriesNowPlayPageState createState() => _TvSeriesNowPlayPageState();
}

class _TvSeriesNowPlayPageState extends State<TvSeriesNowPlayPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<TvSeriesNowPlayNotifier>(context, listen: false)
        ..fetchNowPlayingTvSeriesFromNotifier(),
    );
  }

  AppBar _buildAppBarTvSeriesTopRated() {
    return AppBar(
      title: const Text('Top Rated TV Series'),
    );
  }

  Widget showTvSeriesListWidgetLogic(TvSeriesNowPlayNotifier data) {
    if (data.nowPlayingState == RequestState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (data.nowPlayingState == RequestState.loaded) {
      return ListView.builder(
        itemBuilder: (context, index) {
          // return MovieCard(data.popularTvSeries[index]);
          var tvData = data.nowPlayingTvSeries[index];
          return TvSeriesListWidget(tvData: tvData);
        },
        itemCount: data.nowPlayingTvSeries.length,
      );
    } else {
      return Center(
        key: const Key('this-is-error'),
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
        child: Consumer<TvSeriesNowPlayNotifier>(
          builder: (context, data, child) {
            return showTvSeriesListWidgetLogic(data);
          },
        ),
      ),
    );
  }
}
