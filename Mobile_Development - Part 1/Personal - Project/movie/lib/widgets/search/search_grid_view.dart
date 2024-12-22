import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/widgets/search/grid_view_card.dart';
import 'package:movie/widgets/search/no_results.dart';

class SearchGridView extends StatelessWidget {
  final List<Movie> searchResults;

  const SearchGridView({
    super.key,
    required this.searchResults,
  });

  @override
  Widget build(BuildContext context) {
    if (searchResults.isEmpty) {
      return const NoResults();
    }

    return GridView.builder(
      itemCount: searchResults.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        childAspectRatio: 0.58,
      ),
      itemBuilder: (context, index) {
        return GridViewCard(item: searchResults[index]);
      },
    );
  }
}
