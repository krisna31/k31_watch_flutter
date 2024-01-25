import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_series_now_playing_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_series_popular_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_series_top_rated_bloc.dart';
import 'package:k31_watch_flutter/presentation/pages/search_page_tv.dart';
import 'package:k31_watch_flutter/presentation/pages/tv_series_now_play_page.dart';
import 'package:k31_watch_flutter/presentation/pages/tv_series_popular_page.dart';
import 'package:k31_watch_flutter/presentation/pages/tv_series_top_rated_page.dart';
import 'package:k31_watch_flutter/presentation/widgets/my_drawer.dart';
import 'package:k31_watch_flutter/presentation/widgets/subtitle_widget.dart';
import 'package:k31_watch_flutter/presentation/widgets/tv_series_list.dart';
import 'package:provider/provider.dart';

class HomeTvSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/tv-series';

  const HomeTvSeriesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeTvSeriesPageState createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvSeriesNowPlayingBloc>().add(
            FetchTvSeriesNowPlayingEvent(),
          );
      context.read<TvSeriesPopularBloc>().add(
            FetchTvSeriesPopularEvent(),
          );
      context.read<TvSeriesTopRatedBloc>().add(
            FetchTvSeriesTopRatedEvent(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPageTv.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubtitleWidget(
                title: "Now Playing",
                onTapFunction: () => Navigator.pushNamed(
                  context,
                  TvSeriesNowPlayPage.ROUTE_NAME,
                ),
              ),
              BlocBuilder<TvSeriesNowPlayingBloc, TvSeriesNowPlayingState>(
                builder: (context, state) {
                  switch (state) {
                    case TvSeriesNowPlayingLoading():
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case TvSeriesNowPlayingHasData():
                      return TvSeriesList(state.tvSeries);
                    case TvSeriesNowPlayingError():
                      return Center(
                        child: Text(state.message),
                      );
                    default:
                      return const Text('Failed');
                  }
                },
              ),
              SubtitleWidget(
                title: 'Popular Tv Series',
                onTapFunction: () => Navigator.pushNamed(
                  context,
                  TvSeriesPopularPage.ROUTE_NAME,
                ),
              ),
              BlocBuilder<TvSeriesPopularBloc, TvSeriesPopularState>(
                builder: (context, state) {
                  switch (state) {
                    case TvSeriesPopularLoading():
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case TvSeriesPopularHasData():
                      return TvSeriesList(state.tvSeries);
                    case TvSeriesPopularError():
                      return Center(
                        child: Text(state.message),
                      );
                    default:
                      return const Text('Failed');
                  }
                },
              ),
              SubtitleWidget(
                title: 'Top Rated Tv Series',
                onTapFunction: () => Navigator.pushNamed(
                  context,
                  TvSeriesTopRatedPage.ROUTE_NAME,
                ),
              ),
              BlocBuilder<TvSeriesTopRatedBloc, TvSeriesTopRatedState>(
                builder: (context, state) {
                  switch (state) {
                    case TvSeriesTopRatedLoading():
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case TvSeriesTopRatedHasData():
                      return TvSeriesList(state.tvSeries);
                    case TvSeriesTopRatedError():
                      return Center(
                        child: Text(state.message),
                      );
                    default:
                      return const Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
