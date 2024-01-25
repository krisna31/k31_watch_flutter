import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_series_popular_bloc.dart';

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
      () => context.read<TvSeriesPopularBloc>().add(
            FetchTvSeriesPopularEvent(),
          ),
    );
  }

  Widget showTvSeriesListWidgetLogic(TvSeriesPopularState data) {
    if (data is TvSeriesPopularLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (data is TvSeriesPopularHasData) {
      return ListView.builder(
        itemBuilder: (context, index) {
          // return MovieCard(data.popularTvSeries[index]);
          var tvData = data.tvSeries[index];
          return TvSeriesListWidget(tvData: tvData);
        },
        itemCount: data.tvSeries.length,
      );
    } else if (data is TvSeriesPopularError) {
      return Center(
        child: Text(data.message),
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
      appBar: _buildAppBarTvSeriesPopular(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
          builder: (context, state) {
            return showTvSeriesListWidgetLogic(state);
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
