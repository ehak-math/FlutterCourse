import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/widgets/slider_card_image.dart';

class SliderCard extends StatelessWidget {
  const SliderCard({
    super.key,
    required this.movie,
    required this.itemIndex,
  });

  final Movie movie;
  final int itemIndex;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Stack(
          children: [
            SliderCardImage(imageUrl: movie.backdropPath),
            Padding(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                bottom: 10,
              ),
              child: SizedBox(
                height: size.height * 0.55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                    Text(
                      movie.releaseDate,
                      style: textTheme.labelLarge?.copyWith(
                        color: Colors.grey[600],
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          6,
                          (indexDot) {
                            return Container(
                              margin:
                                  const EdgeInsets.only(right: 10),
                              width: indexDot == itemIndex
                                  ? 30
                                  : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: indexDot == itemIndex
                                    ? Colors.red
                                    : Colors.grey[600],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );  }
}

