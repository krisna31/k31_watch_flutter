import 'package:cached_network_image/cached_network_image.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/presentation/pages/detail_tv_series_page.dart';

class TvSeriesList extends StatelessWidget {
  const TvSeriesList(this.tvSeries, {super.key});
  final List<TvSeries> tvSeries;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSerie = tvSeries[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailTvSeriesPage.ROUTE_NAME,
                  arguments: tvSerie.id,
                );
              },
              child: Hero(
                tag: 'tvSeriesHero${tvSerie.id}',
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: '$baseImageUrl${tvSerie.posterPath}',
                      width: 120,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
