import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/common/index.dart';
import 'package:k31_watch_flutter/presentation/pages/about_page.dart';
import 'package:k31_watch_flutter/presentation/pages/home_movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/movie_detail_page.dart';
import 'package:k31_watch_flutter/presentation/pages/popular_movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/search_page.dart';
import 'package:k31_watch_flutter/presentation/pages/top_rated_movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/watchlist_movie_page.dart';
import 'package:k31_watch_flutter/presentation/providers/movie_detail_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/movie_list_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/movie_search_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/popular_movie.notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/top_rated_movie_notifier.dart';
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
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
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
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
