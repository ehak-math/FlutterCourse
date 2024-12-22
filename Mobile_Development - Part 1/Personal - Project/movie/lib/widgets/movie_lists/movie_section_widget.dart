import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/screen/see_all_sreen.dart';
import 'package:movie/widgets/movie_lists/popular_movie.dart';
import 'package:movie/widgets/movie_lists/top_rated_movie.dart';
import 'package:movie/widgets/movie_lists/upcoming_movie.dart';

class MovieSectionWidget extends StatelessWidget {
  const MovieSectionWidget({
    super.key,
    required this.title,
    required this.moviesFuture,
  });

  final String title;
  final Future<List<Movie>> moviesFuture;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              FutureBuilder<List<Movie>>(
                future: moviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.isEmpty) {
                    return const SizedBox(); // Hide "see all" button if no data
                  }
                  return TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SeeAllSreen(
                                title: title,
                                movies: snapshot.data!,
                              ),
                        ),
                      );
                    },
                    label: const Text('see all'),
                    icon: const Icon(Icons.arrow_forward_ios, size: 15),
                    iconAlignment: IconAlignment.end,
                  );
                },
              ),
            ],
          ),
        ),
        FutureBuilder<List<Movie>>(
          future: moviesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Movies Found'));
            }

            // Display respective movie widget based on the section
            final movies = snapshot.data!;
            if (title == 'Popular Movies') {
              return PopularMovie(popularMovies: movies);
            } else if (title == 'Top Rated Movies') {
              return TopRatedMovie(topRatedMovies: movies);
            } else {
              return UpcomingMovie(upcomingMovie: movies);
            }
          },
        ),
      ],
    );
  }
}
 