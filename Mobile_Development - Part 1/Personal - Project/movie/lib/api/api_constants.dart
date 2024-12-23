import 'dart:convert';
import 'package:movie/models/cast.dart';
import 'package:movie/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiConstants {
  static const String apiKey = 'your api key';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String basePosterUrl = 'https://image.tmdb.org/t/p/w500';
  static const String baseBackdropUrl = 'https://image.tmdb.org/t/p/w1280';
  static const String baseProfileUrl = 'https://image.tmdb.org/t/p/w300';
  static const String baseStillUrl = 'https://image.tmdb.org/t/p/w500';
  static const String baseVideoUrl = 'https://www.youtube.com/watch?v=';

  static const String moviePlaceHolder =
      'https://davidkoepp.com/wp-content/themes/blankslate/images/Movie%20Placeholder.jpg';
  static const String stillPlaceHolder =
      'https://popcornsg.s3.amazonaws.com/gallery/1577405144-six-year.png';

  static const String nowPlayingMoviesPath =
      '$baseUrl/movie/now_playing?api_key=$apiKey';
  static const String popularMoviesPath =
      '$baseUrl/movie/popular?api_key=$apiKey';
  static const String topRatedMoviesPath =
      '$baseUrl/movie/top_rated?api_key=$apiKey';
  static const String upcomingMoviePath =
      '$baseUrl/movie/upcoming?api_key=$apiKey';

  // Helper function for making API requests
  Future<Map<String, dynamic>> _getRequest(String url) async {
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed with status: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch movie trailer URL
  Future<String?> fetchTrailerUrl(int movieId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/movie/$movieId/videos?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;
      if (results.isNotEmpty) {
        final trailerKey = results.length > 1 && results[1]['key'] != null ? results[1]['key'] : results[0]['key']; // Use the second video if available
        return 'https://www.youtube.com/watch?v=$trailerKey';
      }
    } else {
      throw Exception('Failed to load trailer');
    }
    return null;
  }

  // Fetch Now Playing Movies
  Future<List<Movie>> getNowPlayingMovies() async {
    final data = await _getRequest(nowPlayingMoviesPath);
    final results = data['results'] as List;
    return results.map((e) => Movie.fromJson(e)).toList();
  }

  // Fetch Popular Movies
  Future<List<Movie>> getPopularMovies() async {
    final data = await _getRequest(popularMoviesPath);
    final results = data['results'] as List;
    return results.map((e) => Movie.fromJson(e)).toList();
  }

  // Fetch Top Rated Movies
  Future<List<Movie>> getTopRatedMovies() async {
    final data = await _getRequest(topRatedMoviesPath);
    final results = data['results'] as List;
    return results.map((e) => Movie.fromJson(e)).toList();
  }

  // Fetch Upcoming Movies
  Future<List<Movie>> getUpcomingMovies() async {
    final data = await _getRequest(upcomingMoviePath);
    final results = data['results'] as List;
    return results.map((e) => Movie.fromJson(e)).toList();
  }

  // Fetch Movie Details
  Future<Movie> getMovieDetails(int movieId) async {
    final data = await _getRequest('$baseUrl/movie/$movieId?api_key=$apiKey');
    return Movie.fromJson(data);
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/movie/$movieId/credits?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List castList = data['cast'];
      return castList.map((cast) => Cast.fromJson(cast)).toList();
    } else {
      throw Exception('Failed to load cast data');
    }
  }

  Future<List<Movie>> getRecommendationrMovies(int movieId) async {
    final response = await http.get(
        Uri.parse('$baseUrl/movie/$movieId/recommendations?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List results = data['results'];
      return results.map((result) => Movie.fromJson(result)).toList();
    } else {
      throw Exception('Failed to load recommendation movies');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http
        .get(Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List results = data['results'];
      return results.map((result) => Movie.fromJson(result)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }

  Future<List<Movie>> getTrendingMovies() async {
    final response = await http
        .get(Uri.parse('$baseUrl/trending/movie/day?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List results = data['results'];
      return results.map((result) => Movie.fromJson(result)).toList();
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  // Add movie to watchlist

 // Ensure API methods are imported

// Local storage for watchlist functionality
static const String _watchlistKey = 'watchlist';

// Add movie to watchlist
Future<void> addToWatchlist(Movie movie) async {
  final prefs = await SharedPreferences.getInstance();
  final watchlist = await getWatchlist();

  // Check if movie is already in the watchlist
  if (!watchlist.any((m) => m.tmdbID == movie.tmdbID)) {
    watchlist.add(movie);
    // Save movie IDs to SharedPreferences
    await prefs.setStringList(
        _watchlistKey, watchlist.map((m) => m.tmdbID.toString()).toList());
  }
}

// Remove movie from watchlist
Future<void> removeFromWatchlist(Movie movie) async {
  final prefs = await SharedPreferences.getInstance();
  final watchlist = await getWatchlist();

  // Remove movie from the list
  watchlist.removeWhere((m) => m.tmdbID == movie.tmdbID);
  // Save the updated list of movie IDs
  await prefs.setStringList(
      _watchlistKey, watchlist.map((m) => m.tmdbID.toString()).toList());
}

// Get all movies in watchlist
Future<List<Movie>> getWatchlist() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final watchlistStrings = prefs.getStringList(_watchlistKey) ?? [];

    // Convert string list to a list of movie IDs
    final watchlistIds = watchlistStrings.map((str) => int.parse(str)).toList();

    List<Movie> movies = [];
    for (var id in watchlistIds) {
      try {
        // Fetch movie details by ID
        Movie movie = await getMovieDetails(id); // Replace with your actual method to fetch Movie data
        movies.add(movie);
      } catch (e) {
        print('Error fetching movie $id: $e');
      }
    }
    return movies;
  } catch (e) {
    print('Error getting watchlist: $e');
    return [];
  }
}

// Check if movie is in watchlist
Future<bool> isInWatchlist(int movieId) async {
  final watchlist = await getWatchlist();
  // Check if the movie ID is in the watchlist
  return watchlist.any((movie) => movie.tmdbID == movieId);
}

}
