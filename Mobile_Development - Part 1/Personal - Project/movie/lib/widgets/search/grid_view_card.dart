import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/screen/details_sreen.dart';
import 'package:movie/widgets/slider_card_image.dart';

class GridViewCard extends StatelessWidget {
  final Movie item;

  const GridViewCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: item))
            );
          },
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ImageWithShimmer(
                imageUrl: item.posterPath, 
                width: double.infinity, 
                height: 150,
              )
            ),
          ),
        ),
        Expanded(
          child: Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }
}
