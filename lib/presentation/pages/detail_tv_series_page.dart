import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/domain/entities/detail_tv_series.dart';
import 'package:k31_watch_flutter/domain/entities/genre.dart';
import 'package:k31_watch_flutter/presentation/providers/detail_tv_series_notifier.dart';
import 'package:provider/provider.dart';

class DetailTvSeriesPage extends StatefulWidget {
  const DetailTvSeriesPage({super.key, required this.id});
  // ignore: constant_identifier_names

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
      // Provider.of<DetailTvSeriesNotifier>(context, listen: false)
      //     .loadWatchlistStatus(widget.id);
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
            return DetailContent(
              tvSeries,
              // provider.tvSeriesRecommendations,
              // provider.isAddedToWatchlist,
              false,
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final DetailTvSeries tvSeries;
  final bool isAddedWatchlist;

  const DetailContent(this.tvSeries, this.isAddedWatchlist, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tvSeries.name!,
                      style: myTextTheme.titleLarge,
                    ),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     if (!isAddedWatchlist) {
                    //       await Provider.of<DetailTvSeriesNotifier>(
                    //               context,
                    //               listen: false)
                    //           .addWatchlist(tvSeries);
                    //     } else {
                    //       await Provider.of<DetailTvSeriesNotifier>(
                    //               context,
                    //               listen: false)
                    //           .removeFromWatchlist(tvSeries);
                    //     }

                    //     final message =
                    //         // ignore: use_build_context_synchronously
                    //         Provider.of<DetailTvSeriesNotifier>(context,
                    //                 listen: false)
                    //             .watchlistMessage;

                    //     if (message ==
                    //             DetailTvSeriesNotifier
                    //                 .watchlistAddSuccessMessage ||
                    //         message ==
                    //             DetailTvSeriesNotifier
                    //                 .watchlistRemoveSuccessMessage) {
                    //       // ignore: use_build_context_synchronously
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //           SnackBar(content: Text(message)));
                    //     } else {
                    //       // ignore: use_build_context_synchronously
                    //       showDialog(
                    //           context: context,
                    //           builder: (context) {
                    //             return AlertDialog(
                    //               content: Text(message),
                    //             );
                    //           });
                    //     }
                    //   },
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       isAddedWatchlist
                    //           ? const Icon(Icons.check)
                    //           : const Icon(Icons.add),
                    //       const Text('Watchlist'),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0, // Space between chips
                      runSpacing: 8.0, // Space between chip rows
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
                        Text('${tvSeries.voteAverage}')
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Overview',
                      style: myTextTheme.bodyMedium,
                    ),
                    Text(
                      tvSeries.overview!,
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
      labelStyle: const TextStyle(color: Colors.white),
      elevation: 2,
      padding: const EdgeInsets.all(2),
    );
  }
}
