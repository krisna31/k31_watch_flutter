import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/common/index.dart';
import 'package:k31_watch_flutter/presentation/pages/about_page.dart';
import 'package:k31_watch_flutter/presentation/pages/detail_tv_series_page.dart';
import 'package:k31_watch_flutter/presentation/pages/movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/home_tv_series_page.dart';
import 'package:k31_watch_flutter/presentation/pages/movie_detail_page.dart';
import 'package:k31_watch_flutter/presentation/pages/popular_movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/search_page.dart';
import 'package:k31_watch_flutter/presentation/pages/search_page_tv.dart';
import 'package:k31_watch_flutter/presentation/pages/top_rated_movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/tv_series_now_play_page.dart';
import 'package:k31_watch_flutter/presentation/pages/tv_series_top_rated_page.dart';
import 'package:k31_watch_flutter/presentation/pages/tv_series_popular_page.dart';
import 'package:k31_watch_flutter/presentation/pages/watchlist_movie_page.dart';
import 'package:k31_watch_flutter/presentation/providers/detail_tv_series_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/movie_detail_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/movie_list_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/movie_search_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/popular_movie.notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/search_tv_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/top_rated_movie_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_list_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_now_play_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_popular_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_top_rated_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/watch_list_movie_notifier.dart';
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
          create: (_) => di.locator<MovieListNotifier>()
        ),
        ChangeNotifierProvider(
            create: (_) => di.locator<MovieDetailNotifier>()
        ),
        ChangeNotifierProvider(
            create: (_) => di.locator<MovieSearchNotifier>()
        ),
        ChangeNotifierProvider(
            create: (_) => di.locator<TopRatedMoviesNotifier>()
        ),
        ChangeNotifierProvider(
            create: (_) => di.locator<PopularMoviesNotifier>()
        ),
        ChangeNotifierProvider(
            create: (_) => di.locator<WatchlistMovieNotifier>()
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
        ChangeNotifierProvider(
          create: (_) => di.locator<DetailTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchTvNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'K31 Movie',
        theme: ThemeData.dark().copyWith(
          colorScheme: k31ColorScheme,
          primaryColor: primary,
          scaffoldBackgroundColor: primary,
          textTheme: myTextTheme,
        ),
        home: const HomeTvSeriesPage(),
        navigatorObservers: [routeObserver],
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
            case DetailTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) =>
                    DetailTvSeriesPage(id: settings.arguments as int),
                settings: settings,
              );
            case SearchPageTv.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => const SearchPageTv(),
              );
            case MoviePage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => const MoviePage(),
              );
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: settings.arguments as int),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('404 NOT FOUND 404'),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
