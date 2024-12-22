import 'package:flutter/material.dart';
import 'package:movie/api/api_constants.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/widgets/watch_lists/empty_watchlist_text.dart';
import 'package:movie/widgets/watch_lists/watchlist_movie.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  late Future<List<Movie>> _watchlistMoviesFuture;

  @override
  void initState() {
    super.initState();
    _watchlistMoviesFuture = ApiConstants().getWatchlist();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: _watchlistMoviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final watchlistMovies = snapshot.data!;
          if (watchlistMovies.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Watchlist', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold),),
                centerTitle: true,
              ),
              body: const Center(child: EmptyWatchlistText()),
            );
          }
          return WatchlistMovies(movies: watchlistMovies, title: 'Watchlist');
        } else {
          return const Center(child: EmptyWatchlistText());
        }
      },
    );
  }
}
