import 'package:k31_watch_flutter/common/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';
import 'package:k31_watch_flutter/presentation/pages/movie_detail_page.dart';

class MovieListWidget extends StatelessWidget {
  final List<Movie> moviesList;
  const MovieListWidget(this.moviesList, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 212,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = moviesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    15,
                  ),
                ),
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                  ),
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: moviesList.length,
      ),
    );
  }
}
