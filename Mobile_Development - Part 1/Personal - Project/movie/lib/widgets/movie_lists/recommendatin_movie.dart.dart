import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/widgets/slider_card_image.dart';

class RecommendationMovies extends StatelessWidget {
  const RecommendationMovies({
    super.key,
    required this.recommendationMovies,
    required this.onMovieTap
  });

  final List<Movie> recommendationMovies;
  final Function(Movie) onMovieTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: recommendationMovies.length,
              itemBuilder: (context, index) {
              final movie = recommendationMovies[index];
              return GestureDetector(
                onTap: () => onMovieTap(movie),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ImageWithShimmer(
                          imageUrl: movie.posterPath,
                          width: 120,
                          height: 170,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 120, // Match the poster width
                        child: Text(
                          movie.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelLarge,
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
