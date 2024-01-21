import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/presentation/common/utils.dart';
import 'package:k31_watch_flutter/presentation/pages/search_page.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_list_notifier.dart';
import 'package:k31_watch_flutter/presentation/widgets/my_drawer.dart';
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
    Future.microtask(
      () => Provider.of<TvSeriesListNotifier>(context, listen: false)
        ..fetchNowPlayingTvSeries(),
      // ..fetchPopularMovies()
      // ..fetchTopRatedMovies(),
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
              // _buildSubHeading(
              //   title: 'Popular',
              //   onTap: () =>
              //       Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              // ),
              // Consumer<MovieListNotifier>(builder: (context, data, child) {
              //   final state = data.popularMoviesState;
              //   if (state == RequestState.loading) {
              //     return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (state == RequestState.loaded) {
              //     return MovieList(data.popularMovies);
              //   } else {
              //     return const Text('Failed');
              //   }
              // }),
              // _buildSubHeading(
              //   title: 'Top Rated',
              //   onTap: () =>
              //       Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              // ),
              // Consumer<MovieListNotifier>(builder: (context, data, child) {
              //   final state = data.topRatedMoviesState;
              //   if (state == RequestState.loading) {
              //     return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (state == RequestState.loaded) {
              //     return MovieList(data.topRatedMovies);
              //   } else {
              //     return const Text('Failed');
              //   }
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
