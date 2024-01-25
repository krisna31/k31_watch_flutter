import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_series_now_playing_bloc.dart';

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
      () => context.read<TvSeriesNowPlayingBloc>().add(
            FetchTvSeriesNowPlayingEvent(),
          ),
    );
  }

  AppBar _buildAppBarTvSeriesTopRated() {
    return AppBar(
      title: const Text('Top Rated TV Series'),
    );
  }

  Widget showTvSeriesListWidgetLogic(TvSeriesNowPlayingState state) {
    if (state is TvSeriesNowPlayingLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is TvSeriesNowPlayingHasData) {
      return ListView.builder(
        itemBuilder: (context, index) {
          // return MovieCard(data.popularTvSeries[index]);
          var tvData = state.tvSeries[index];
          return TvSeriesListWidget(tvData: tvData);
        },
        itemCount: state.tvSeries.length,
      );
    } else if (state is TvSeriesNowPlayingError) {
      return Center(
        child: Text(state.message),
      );
    } else {
      return const Center(
        key: Key('this-is-error'),
        child: Text("SOmehting went wrong"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarTvSeriesTopRated(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
          builder: (context, state) {
            return showTvSeriesListWidgetLogic(state);
          },
        ),
      ),
    );
  }
}
