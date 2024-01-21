import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/presentation/common/utils.dart';
import 'package:k31_watch_flutter/presentation/pages/popular_tv_series_page.dart';
import 'package:k31_watch_flutter/presentation/pages/search_page.dart';
import 'package:k31_watch_flutter/presentation/pages/top_rated_tv_series_page.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_list_notifier.dart';
import 'package:k31_watch_flutter/presentation/widgets/my_drawer.dart';
import 'package:k31_watch_flutter/presentation/widgets/subtitle_widget.dart';
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
    Future.microtask(
      () => Provider.of<TvSeriesListNotifier>(context, listen: false)
        ..fetchNowPlayingTvSeries()
        ..fetchPopularTvSeries()
        ..fetchTopRatedTvSeries(),
    );
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
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
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
              Text('Now Playing', style: myTextTheme.bodyMedium),
              Consumer<TvSeriesListNotifier>(
                builder: (context, data, child) => showTvSeriesCardLogic(
                  data.nowPlayingState,
                  data.nowPlayingTvSeries,
                ),
              ),
              SubtitleWidget(
                title: 'Popular Tv Series',
                onTapFunction: () => Navigator.pushNamed(
                  context,
                  PopularTvSeriesPage.ROUTE_NAME,
                ),
              ),
              Consumer<TvSeriesListNotifier>(
                builder: (context, data, child) => showTvSeriesCardLogic(
                  data.popularTvSeriesState,
                  data.popularTvSeries,
                ),
              ),
              SubtitleWidget(
                title: 'Top Rated Tv Series',
                onTapFunction: () => Navigator.pushNamed(
                  context,
                  TopRatedTvSeriesPage.ROUTE_NAME,
                ),
              ),
              Consumer<TvSeriesListNotifier>(
                builder: (context, data, child) => showTvSeriesCardLogic(
                  data.topRatedTvSeriesState,
                  data.topRatedTvSeries,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
