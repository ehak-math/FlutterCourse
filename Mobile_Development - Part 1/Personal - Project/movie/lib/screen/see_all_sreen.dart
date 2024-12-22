import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/screen/details_sreen.dart';
import 'package:movie/widgets/slider_card_image.dart';


class SeeAllSreen extends StatelessWidget {
  const SeeAllSreen({
    super.key,
    required this.movies,
    required this.title,
  });

  final List<Movie> movies;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: ListView.builder(
        itemCount: movies.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
               MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie))
              );
            },
            child: Container(
              height: 175,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ImageWithShimmer(
                        imageUrl: movie.posterPath,
                        width: 110,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            movie.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            if (movie.releaseDate.isNotEmpty) ...[
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Text(
                                  movie.releaseDate,
                                  // Show year only
                                  textAlign: TextAlign.center,
                                  style: textTheme.labelLarge,
                                ),
                              ),
                            ],
                            const Icon(
                              Icons.star_rate_rounded,
                              color: Color(0xffffbe21),
                              size: 18,
                            ),
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
                              // Ensure proper formatting
                              style: textTheme.labelLarge,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: Text(
                            movie.overview,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
