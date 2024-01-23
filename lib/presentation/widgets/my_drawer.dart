import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/presentation/pages/about_app_page.dart';
import 'package:k31_watch_flutter/presentation/pages/movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/home_tv_series_page.dart';
import 'package:k31_watch_flutter/presentation/pages/watchlist_movie_page.dart';
import 'package:k31_watch_flutter/presentation/pages/watchlist_tv_series_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/logo.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('TV Series'),
            onTap: () {
              Navigator.pushNamed(context, HomeTvSeriesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Watchlist Tv  Series'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistTvSeriesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              Navigator.pushNamed(context, MoviePage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist Movies'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutAppPage.ROUTE_NAME);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}
