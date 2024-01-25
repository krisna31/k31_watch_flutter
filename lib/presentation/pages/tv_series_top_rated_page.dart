import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_series_top_rated_bloc.dart';

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
      () => context.read<TvSeriesTopRatedBloc>().add(
          FetchTvSeriesTopRatedEvent(),
        )
    );
  }

  AppBar _buildAppBarTvSeriesTopRated() {
    return AppBar(
      title: const Text('Top Rated TV Series'),
    );
  }

  Widget showTvSeriesListWidgetLogic(TvSeriesTopRatedState data) {
    switch (data) {
      case TvSeriesTopRatedLoading():
        return const Center(
          child: CircularProgressIndicator(),
        );
      case TvSeriesTopRatedHasData():
        return ListView.builder(
          itemBuilder: (context, index) {
            // return MovieCard(data.popularTvSeries[index]);
            var tvData = data.tvSeries[index];
            return TvSeriesListWidget(tvData: tvData);
          },
          itemCount: data.tvSeries.length,
        );
      case TvSeriesTopRatedError():
        return Center(
          child: Text(data.message),
        );
      default:
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
        child: BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
          builder: (context, data) {
            return showTvSeriesListWidgetLogic(data);
          },
        ),
      ),
    );
  }
}
