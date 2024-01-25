import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/common/route_observer.dart';
import 'package:k31_watch_flutter/presentation/bloc/detail_tv_series_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/popular_movie_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/search_movie_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/search_tv_series_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_recommendations_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_watchlist_status_bloc.dart';
import 'package:k31_watch_flutter/presentation/pages/about_app_page.dart';
import 'package:k31_watch_flutter/presentation/pages/detail_tv_series_page.dart';
import 'package:k31_watch_flutter/presentation/pages/movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/home_tv_series_page.dart';
import 'package:k31_watch_flutter/presentation/pages/movie_detail_page.dart';
import 'package:k31_watch_flutter/presentation/pages/popular_movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/search_page_movie.dart';
import 'package:k31_watch_flutter/presentation/pages/search_page_tv.dart';
import 'package:k31_watch_flutter/presentation/pages/top_rated_movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/tv_series_now_play_page.dart';
import 'package:k31_watch_flutter/presentation/pages/tv_series_top_rated_page.dart';
import 'package:k31_watch_flutter/presentation/pages/tv_series_popular_page.dart';
import 'package:k31_watch_flutter/presentation/pages/watchlist_movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/watchlist_tv_series_page.dart';
import 'package:k31_watch_flutter/presentation/providers/movie_detail_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/movie_list_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/top_rated_movie_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_list_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_now_play_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_popular_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_top_rated_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/watch_list_movie_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/watch_list_tv_series_notifier.dart';

import 'package:provider/provider.dart';
import 'package:k31_watch_flutter/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesPopularNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesTopRatedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesNowPlayNotifier>(),
        ),

        // bloc
        BlocProvider(
          create: (_) => di.locator<SearchTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          colorScheme: k31ColorScheme.copyWith(primary: primary),
          primaryColor: primary,
          scaffoldBackgroundColor: primary,
          textTheme: myTextTheme.copyWith(
            titleLarge: myTextTheme.titleLarge,
          ),
        ),
        title: 'K31 Watch Flutter',
        navigatorObservers: [routeObserver],
        home: const HomeTvSeriesPage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => const HomeTvSeriesPage(),
              );
            case TvSeriesPopularPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => const TvSeriesPopularPage(),
              );
            case TvSeriesTopRatedPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => const TvSeriesTopRatedPage(),
              );
            case TvSeriesNowPlayPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => const TvSeriesNowPlayPage(),
              );
            case WatchlistTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => const WatchlistTvSeriesPage(),
              );
            case DetailTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) =>
                    DetailTvSeriesPage(id: settings.arguments as int),
                settings: settings,
              );
            // ! test 404 page
            case SearchPageTv.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => const SearchPageTv(),
              );
            case MoviePage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => const MoviePage(),
              );
            case PopularMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: settings.arguments as int),
                settings: settings,
              );
            case SearchPageMovie.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => const SearchPageMovie(),
              );
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case AboutAppPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => const AboutAppPage(),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => const PageNotFoundWidget(),
              );
          }
        },
      ),
    );
  }
}

class PageNotFoundWidget extends StatelessWidget {
  const PageNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '404',
              style: TextStyle(
                fontSize: 72.0,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'NOT FOUND',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Oops! The page you are looking for does not exist.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeTvSeriesPage.ROUTE_NAME);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
