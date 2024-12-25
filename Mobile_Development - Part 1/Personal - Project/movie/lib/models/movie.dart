import 'package:movie/functions/function.dart';
import 'package:movie/models/cast.dart';

class Movie {
  final int? runtime;
  final String? trailerUrl;
  final List<dynamic>? genres;
  final int tmdbID;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final List<Cast>? cast;

  Movie({
    required this.tmdbID,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    this.runtime,
    this.trailerUrl,
    this.genres,
    this.cast
  });



  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      tmdbID: json['id'],
      title: json['title'],
      posterPath: getPosterUrl(json['poster_path']),
      backdropPath: getBackdropUrl(json['backdrop_path']),
      overview: json['overview'],
      releaseDate: getDate(json['release_date']),
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      runtime: json['runtime'],
      trailerUrl: json['trailer_url'] ?? '',
      genres: json['genres'] ?? [],
    );
  }

}
