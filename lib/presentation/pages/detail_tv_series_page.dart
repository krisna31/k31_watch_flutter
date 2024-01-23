import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/presentation/providers/detail_tv_series_notifier.dart';
import 'package:provider/provider.dart';

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
      Provider.of<DetailTvSeriesNotifier>(context, listen: false)
          .fetchDetailTvSeries(widget.id);
      Provider.of<DetailTvSeriesNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tv Series'),
      ),
      body: Consumer<DetailTvSeriesNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeriesState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesState == RequestState.loaded) {
            final tvSeries = provider.tvSeries;
            return TvSeriesDetailContent(tvSeries, provider.isAddedToWatchlist);
          } else {
            return Center(
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}

class TvSeriesDetailContent extends StatelessWidget {
  final DetailTvSeries tvSeries;
  final bool isAddedWatchlist;

  const TvSeriesDetailContent(this.tvSeries, this.isAddedWatchlist, {Key? key})
      : super(key: key);

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
                    ElevatedButton(
                      onPressed: () async {
                        if (isAddedWatchlist) {
                          await Provider.of<DetailTvSeriesNotifier>(context,
                                  listen: false)
                              .removeFromWatchlist(tvSeries);
                        } else {
                          await Provider.of<DetailTvSeriesNotifier>(context,
                                  listen: false)
                              .addWatchlist(tvSeries);
                        }

                        Fluttertoast.showToast(
                          // ignore: use_build_context_synchronously
                          msg: context
                              .read<DetailTvSeriesNotifier>()
                              .watchlistMessage,
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
                    Consumer<DetailTvSeriesNotifier>(
                      builder: (context, data, child) {
                        if (data.recommendationState == RequestState.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (data.recommendationState ==
                            RequestState.error) {
                          return Center(
                            child: Text(
                              data.message,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else if (data.recommendationState ==
                            RequestState.loaded) {
                          return SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final tvSeries =
                                    data.recommendationsTvSEries[index];
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
                              itemCount: data.recommendationsTvSEries.length,
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
