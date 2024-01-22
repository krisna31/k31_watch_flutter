import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/domain/entities/tv_series.dart';
import 'package:k31_watch_flutter/presentation/pages/detail_tv_series_page.dart';

class TvSeriesList extends StatelessWidget {
  const TvSeriesList(this.tvSeries, {super.key});

  final List<TvSeries> tvSeries;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 222,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSerie = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailTvSeriesPage.ROUTE_NAME,
                  arguments: tvSerie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tvSerie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
