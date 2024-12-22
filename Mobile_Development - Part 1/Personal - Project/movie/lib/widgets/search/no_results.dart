import 'package:flutter/material.dart';
import 'package:movie/api/api_constants.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/widgets/search/search_grid_view.dart';


class NoResults extends StatefulWidget {
  const NoResults({super.key,});


  @override
  State<NoResults> createState() => _NoResultsState();
}

class _NoResultsState extends State<NoResults> {
  late Future<List<Movie>> _trendingMoviseFuture;

  @override
  void initState() {
    _trendingMoviseFuture = ApiConstants().getTrendingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _trendingMoviseFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SearchGridView(searchResults: snapshot.data!);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
