import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/screen/details_sreen.dart';
import 'package:movie/widgets/slider_card_image.dart';

class TopRatedMovie extends StatelessWidget {
  const TopRatedMovie({
    super.key,
    required this.topRatedMovies,
  });

  final List<Movie> topRatedMovies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox(
              height: 220, // Adjust height to fit poster and title
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                final movie = topRatedMovies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie))
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
    );
  }
}
