import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/presentation/bloc/detail_tv_series_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_recommendations_bloc.dart';
import 'package:k31_watch_flutter/presentation/bloc/tv_watchlist_status_bloc.dart';

class DetailTvSeriesPage extends StatefulWidget {
  const DetailTvSeriesPage({Key? key, required this.id}) : super(key: key);

  final int id;

  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/detail-tv-series';

  @override
  // ignore: library_private_types_in_public_api
  _DetailTvSeriesPageState createState() => _DetailTvSeriesPageState();
}

class _DetailTvSeriesPageState extends State<DetailTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<DetailTvSeriesBloc>(context)
          .add(FetchDetailTvSeriesEvent(id: widget.id));
      BlocProvider.of<TvWatchlistStatusBloc>(context)
          .add(FetchTvWatchlistStatusEvent(id: widget.id));
      BlocProvider.of<TvRecommendationsBloc>(context)
          .add(FetchTvRecommendationsEvent(id: widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tv Series'),
      ),
      body: BlocBuilder<DetailTvSeriesBloc, DetailTvSeriesState>(
        builder: (context, state) {
          if (state is DetailTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailTvSeriesLoaded) {
            return TvSeriesDetailContent(state.tvSeries);
          } else if (state is DetailTvSeriesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}

class TvSeriesDetailContent extends StatelessWidget {
  final DetailTvSeries tvSeries;

  const TvSeriesDetailContent(this.tvSeries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Hero(
          tag: 'tvSeriesHero${tvSeries.id}',
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tvSeries.name!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<TvWatchlistStatusBloc, TvWatchlistStatusState>(
                      builder: (context, state) {
                        if (state is TvWatchlistStatusLoaded) {
                          var isAddedWatchlist = state.isAdded;
                          return ElevatedButton(
                            onPressed: () async {
                              if (isAddedWatchlist) {
                                context.read<TvWatchlistStatusBloc>().add(
                                      RemoveTvWatchlistEvent(
                                          tvSeries: tvSeries),
                                    );
                              } else {
                                context.read<TvWatchlistStatusBloc>().add(
                                      AddTvWatchlistEvent(tvSeries: tvSeries),
                                    );
                              }

                              Fluttertoast.showToast(
                                // ignore: use_build_context_synchronously
                                msg: state.isAdded
                                    ? removedFromTvList
                                    : addedFromTvList,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black87,
                                textColor: Colors.white,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isAddedWatchlist ? Colors.green : Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
                        } else if (state is TvWatchlistStatusLoading) {
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
                      children: tvSeries.genres!
                          .map((genre) => buildGenreChip(genre.name))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: tvSeries.voteAverage! / 2,
                          itemCount: 5,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: warning,
                          ),
                          itemSize: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${tvSeries.voteAverage}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tvSeries.overview!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Recommendations',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<TvRecommendationsBloc, TvRecommendationsState>(
                      builder: (context, state) {
                        if (state is TvRecommendationsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is TvRecommendationsError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else if (state is TvRecommendationsHasData) {
                          return SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final tvSeries = state.tvSeries[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        DetailTvSeriesPage.ROUTE_NAME,
                                        arguments: tvSeries.id,
                                      );
                                    },
                                    child: Container(
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: state.tvSeries.length,
                            ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildGenreChip(String genre) {
    return Chip(
      label: Text(genre),
      backgroundColor: Colors.blue,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      elevation: 2,
      padding: const EdgeInsets.all(8),
    );
  }
}
