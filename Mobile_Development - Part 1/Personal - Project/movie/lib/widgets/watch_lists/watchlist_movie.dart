import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/screen/details_sreen.dart';
import 'package:movie/widgets/slider_card_image.dart';
import 'package:movie/api/api_constants.dart'; // Import your API method

class WatchlistMovies extends StatefulWidget {
  const WatchlistMovies({
    super.key,
    required this.movies,
    required this.title,
  });

  final List<Movie> movies;
  final String title;

  @override
  State<WatchlistMovies> createState() => _WatchlistMoviesState();
}

class _WatchlistMoviesState extends State<WatchlistMovies> {
  late List<Movie> _movies;
  Movie? _removedMovie; // Variable to temporarily store the removed movie
  int? _removedIndex; // Store the index of the removed movie

  @override
  void initState() {
    super.initState();
    _movies = List.from(widget.movies); // Make a copy of the movies list
  }

  // Handle movie removal
  void _removeMovie(Movie movie, int index) async {
    // Call the removeFromWatchlist API method to update SharedPreferences
    await ApiConstants().removeFromWatchlist(movie);

    // Temporarily store the movie and its index
    setState(() {
      _removedMovie = movie;
      _removedIndex = index;
      _movies.removeAt(index);
    });

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).clearSnackBars();

    // Show a SnackBar to notify the user and allow undo
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text('${movie.title} removed from watchlist',),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: _undoRemove, // Handle undo action
        ),
      ),
    );
  }

  // Undo the removal of the movie
  void _undoRemove() {
    if (_removedMovie != null && _removedIndex != null) {
      setState(() {
        // Restore the movie to its previous position
        _movies.insert(_removedIndex!, _removedMovie!);
      });
      // Optionally, re-add the movie to SharedPreferences if needed
      ApiConstants().addToWatchlist(_removedMovie!);
    }
  }

  // Handle movie reorder
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final movie = _movies.removeAt(oldIndex);
      _movies.insert(newIndex, movie);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ReorderableListView(
          onReorder: _onReorder,
          children: List.generate(
            _movies.length,
            (index) {
              final movie = _movies[index];
              return Dismissible(
                key: Key(movie.tmdbID.toString()), // Use tmdbID as the unique key
                onDismissed: (direction) {
                  // Remove movie from the watchlist
                  _removeMovie(movie, index);
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 30),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movie: movie),
                      ),
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
                                    fontWeight: FontWeight.bold,
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
                                    style: textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14, right: 40),
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
