import 'package:http/http.dart' as http;
import 'package:k31_watch_flutter/data/datasources/db/db_helper_movies.dart';
import 'package:k31_watch_flutter/data/datasources/db/db_helper_tv_series.dart';
import 'package:k31_watch_flutter/data/datasources/local_data_tv_series_source.dart';
import 'package:k31_watch_flutter/data/datasources/movie_local_data_source.dart';
import 'package:k31_watch_flutter/data/datasources/movie_remote_data_source.dart';
import 'package:k31_watch_flutter/domain/use_case/get_recommendations_tv_series.dart';
import 'package:k31_watch_flutter/data/repositories_impl/movie_repository_impl.dart';
import 'package:k31_watch_flutter/domain/use_case/get_now_playing_movies.dart';
import 'package:k31_watch_flutter/data/repositories_impl/tv_series_repository_impl.dart';
import 'package:k31_watch_flutter/domain/repositories/movie_repositories.dart';
import 'package:k31_watch_flutter/domain/repositories/tv_series_repositories.dart';
import 'package:k31_watch_flutter/domain/use_case/get_detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_movie_detail.dart';
import 'package:k31_watch_flutter/domain/use_case/get_movie_recommendations.dart';
import 'package:get_it/get_it.dart';
import 'package:k31_watch_flutter/domain/use_case/get_now_playing_tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_popular_movies.dart';
import 'package:k31_watch_flutter/domain/use_case/search_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/get_popular_tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_top_rated_movies.dart';
import 'package:k31_watch_flutter/domain/use_case/get_top_rated_tv_series.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_movies.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_status.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_status_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/get_watch_list_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/remove_watch_list.dart';
import 'package:k31_watch_flutter/data/datasources/tv_series_remote_data_source.dart';
import 'package:k31_watch_flutter/domain/use_case/remove_watch_list_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/save_watch_list.dart';
import 'package:k31_watch_flutter/domain/use_case/save_watch_list_tv.dart';
import 'package:k31_watch_flutter/domain/use_case/search_movies.dart';
import 'package:k31_watch_flutter/presentation/bloc/detail_tv_series_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/popular_movie_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/search_movie_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/search_tv_series_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_recommendations_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_watchlist_status_bloc.dart';
import 'package:k31_watch_flutter/presentation/providers/movie_detail_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/movie_list_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/top_rated_movie_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/watch_list_tv_series_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_list_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_now_play_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_popular_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/tv_series_top_rated_notifier.dart';
import 'package:k31_watch_flutter/presentation/providers/watch_list_movie_notifier.dart';
final locator = GetIt.instance;
void init() {
  // provider
  locator.registerFactory(
    () => WatchlistTvSeriesNotifier(
      getWatchlistTv: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesListNotifier(
      getNowPlayingTvSeries: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesNowPlayNotifier(
      getNowPlayingTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesTopRatedNotifier(
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesPopularNotifier(
      getPopularTvSeries: locator(),
    ),
  );

  // bloc
  locator.registerFactory(
    () => SearchTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvWatchlistStatusBloc(
      getWatchListStatus: locator(),
      saveWatchlistTv: locator(),
      removeWatchlistTv: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovieBloc(
      locator(),
    ),
  );




  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetDetailTvSeries(locator()));
  locator.registerLazySingleton(() => GetRecommendationsTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  
  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImplementation(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImplementation(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(
      dbHelper: locator(),
    ),
  );
  locator.registerLazySingleton<LocalDataTvSeriesSource>(
    () => LocalDataTvSourceImplementation(
      dbHelper: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  // helper
  locator.registerLazySingleton<DbHelperMovies>(() => DbHelperMovies());
  locator.registerLazySingleton<DbHelperTvSeries>(() => DbHelperTvSeries());
  // external
  locator.registerLazySingleton(() => http.Client());
}
