import 'package:flutter/material.dart';
import 'package:movie/api/api_constants.dart';
import 'package:movie/functions/function.dart';
import 'package:movie/models/cast.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/widgets/circle_dot.dart';
import 'package:movie/widgets/movie_lists/movie_cast.dart';
import 'package:movie/widgets/movie_lists/recommendatin_movie.dart.dart';
import 'package:movie/widgets/slider_card_image.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<Movie> _movieDetailsFuture;
  late Future<List<Cast>> _movieCastFuture;
  late Future<String?> _trailerUrlFuture;
  late Future<List<Movie>> _recommendationMoviesFuture;
   late Future<bool> _isInWatchlistFuture;

  @override
  void initState() {
    super.initState();
    _movieCastFuture = ApiConstants().getMovieCast(widget.movie.tmdbID);
    _movieDetailsFuture = ApiConstants().getMovieDetails(widget.movie.tmdbID);
    _trailerUrlFuture = ApiConstants().fetchTrailerUrl(widget.movie.tmdbID);
    _recommendationMoviesFuture = ApiConstants().getRecommendationrMovies(widget.movie.tmdbID);
    _isInWatchlistFuture = ApiConstants().isInWatchlist(widget.movie.tmdbID);
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Movie>(
          future: _movieDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final movie = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SliderCardImage(imageUrl: widget.movie.backdropPath),
                        Positioned(
                          top: 20,
                          left: 20,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black45,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () {
                                Navigator.popUntil(context, (route) => route.isFirst);
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black45,
                            ),
                            child: FutureBuilder<bool>(
                              future: _isInWatchlistFuture,
                              builder: (context, watchlistSnapshot) {
                                if (watchlistSnapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (watchlistSnapshot.hasError) {
                                  return const Icon(Icons.error);
                                } else if (watchlistSnapshot.hasData && watchlistSnapshot.data!) {
                                  return IconButton(
                                    icon: const Icon(Icons.bookmark, color: Colors.white),
                                    onPressed: () async {
                                      await ApiConstants().removeFromWatchlist(movie);
                                      setState(() {
                                        _isInWatchlistFuture = ApiConstants().isInWatchlist(movie.tmdbID); // Refresh watchlist status
                                      });
                                    },
                                  );
                                } else {
                                  return IconButton(
                                    tooltip: 'Save',
                                    icon:  const Icon(
                                      Icons.bookmark_border, 
                                      color: Colors.white
                                    ),
                                    onPressed: () async {
                                      await ApiConstants().addToWatchlist(movie);
                                      setState(() {
                                        _isInWatchlistFuture = ApiConstants().isInWatchlist(movie.tmdbID); // Refresh watchlist status
                                      });
                                    },
                                  );
                                }
                              },
                            ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 16,
                            left: 16,
                            bottom: 10,
                          ),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                              movie.releaseDate.split(',')[1] ,
                                            style: textTheme.bodyMedium?.copyWith(
                                              color: Colors.grey[600]
                                            ),
                                          ),
                                          const CircleDot(),
                                          Text(
                                            getGenres(movie.genres!) ,
                                            style: textTheme.bodyMedium?.copyWith(
                                              color: Colors.grey[600]
                                            ),
                                          ),
                                          const CircleDot(),
                                          Text(
                                            getFormatRuntime(movie.runtime!) ,
                                            style: textTheme.bodyMedium?.copyWith(
                                              color: Colors.grey[600]
                                            ),
                                          ),

                                        ],
                                      ),
                                      
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star_rate_rounded,
                                            color: Color(0xffffbe21),
                                            size: 18,
                                          ),
                                          Text(
                                            movie.voteAverage.toStringAsFixed(1),
                                            style: textTheme.labelLarge?.copyWith(
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            getVotesCount(movie.voteCount),
                                            style: textTheme.bodyMedium?.copyWith(
                                              color: Colors.grey[600]
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                FutureBuilder<String?>(
                                  future: _trailerUrlFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(child: Text('Error: ${snapshot.error}'));
                                    } else if (snapshot.hasData && snapshot.data != null) {
                                      final trailerUrl = snapshot.data!;
                                      return GestureDetector(
                                          onTap: () async {
                                            final url = Uri.parse(trailerUrl);
                                            if (await canLaunchUrl(url)) {
                                              await launchUrl(url);
                                            }
                                          },
                                          child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.play_arrow_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                        );
                                    } else {
                                      return const Text('');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'Story',
                            style: textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            movie.overview.isNotEmpty
                                ? movie.overview
                                : 'Overview not available.',
                            style: textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600]
                              ),
                          ),
                          const SizedBox(height: 10),
                          Text('Cast',
                            style: textTheme.titleLarge,
                          ),
                          FutureBuilder<List<Cast>>(
                            future: _movieCastFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                final cast = snapshot.data!;
                                return MovieCast(cast: cast);
                              } else {
                                return const Center(child: Text('No cast information available.'));
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          // Similar movie
                          Text('Recommendations',
                            style: textTheme.titleLarge,
                          ),
                          FutureBuilder<List<Movie>>(
                            future: _recommendationMoviesFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                final movie = snapshot.data!;
                                return RecommendationMovies(
                                  recommendationMovies: movie,
                                  onMovieTap: (movie) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetailScreen(movie: movie),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(child: Text('No similar movies available.'));
                              }
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No movie details available.'));
            }
          },
        ),
      ),
    );
  }
}
