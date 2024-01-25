import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/domain/entities/movie_detail.dart';
import 'package:k31_watch_flutter/presentation/bloc/movie_detail_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/movie_recommendations_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/movie_watchlist_status_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/detail';

  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(FetchMovieDetailFromBloc(widget.id));
      context.read<MovieRecommendationsBloc>().add(
            FetchMovieRecommendationsFromBloc(widget.id),
          );
      context.read<MovieWatchlistStatusBloc>().add(
            FetchMovieWatchlistStatusFromBloc(widget.id),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailHasData) {
            final movie = state.movieDetail;
            return SafeArea(
              child: DetailContent(
                movie
              ),
            );
          } else if (state is MovieDetailError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;

  const DetailContent(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: myTextTheme.titleLarge,
                            ),
                            BlocBuilder<MovieWatchlistStatusBloc,
                                MovieWatchlistStatusState>(
                              builder: (context, state) {
                                if (state is MovieWatchlistStatusHasData) {
                                  var isAddedWatchlist = state.isAdded;
                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (isAddedWatchlist) {
                                        context
                                            .read<MovieWatchlistStatusBloc>()
                                            .add(
                                              RemoveMovieFromWatchlistFromBloc(
                                                  movie),
                                            );
                                      } else {
                                        context
                                            .read<MovieWatchlistStatusBloc>()
                                            .add(
                                              AddMovieToWatchlistFromBloc(
                                                  movie),
                                            );
                                      }

                                      Fluttertoast.showToast(
                                        // ignore: use_build_context_synchronously
                                        msg: state.isAdded
                                            ? "Removed from watchlist"
                                            : "Added to watchlist",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.black87,
                                        textColor: Colors.white,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isAddedWatchlist
                                          ? Colors.green
                                          : Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 4,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isAddedWatchlist ? Icons.check : Icons.add,
                                    color: Colors.white,
                                  ),
                                          const SizedBox(width: 8),
                                  const Text(
                                    'Watchlist',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                  ),
                                ],
                              ),
                            ),
                                  );
                                } else if (state
                                    is MovieWatchlistStatusLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return const Center(
                                    child: Text(
                                      "Something went wrong",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: movie.genres
                                  .map((e) => buildGenreChip(e.name))
                                  .toList(),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: warning,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: myTextTheme.bodyMedium,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: myTextTheme.bodyMedium,
                            ),
                            BlocBuilder<MovieRecommendationsBloc,
                                MovieRecommendationsState>(
                              builder: (context, state) {
                                switch (state) {
                                  case MovieRecommendationsLoading():
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  case MovieRecommendationsError():
                                    return Text(state.message);
                                  case MovieRecommendationsHasData():
                                    return MovieRecomendationWidgetCard(
                                      recommendations: state.movies,
                                    );
                                  default:
                                    return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

Widget buildGenreChip(String genre) {
    return Chip(
      label: Text(genre),
      backgroundColor: Colors.blue,
      labelStyle: const TextStyle(color: Colors.white),
      elevation: 2,
      padding: const EdgeInsets.all(2),
    );
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class MovieRecomendationWidgetCard extends StatelessWidget {
  const MovieRecomendationWidgetCard({
    super.key,
    required this.recommendations,
  });

  final List<Movie> recommendations;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = recommendations[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: recommendations.length,
      ),
    );
  }
}
