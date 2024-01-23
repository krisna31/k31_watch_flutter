import 'package:k31_watch_flutter/common/constants.dart';
import 'package:k31_watch_flutter/presentation/pages/movie_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/domain/entities/movie.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget(this.moviesList, {super.key});
  final List<Movie> moviesList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = moviesList[index];

          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      imageUrl: '$baseImageUrl${movie.posterPath}',
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      fadeInDuration: const Duration(milliseconds: 300),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
            ),
          );
        },
        itemCount: moviesList.length,
      ),
    );
  }
}
