import 'package:flutter/material.dart';
import 'package:movie/models/cast.dart';
import 'package:movie/widgets/slider_card_image.dart';

class MovieCast extends StatelessWidget {
  const MovieCast({
    super.key,
    required this.cast,
  });

  final List<Cast> cast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: cast.length,
              itemBuilder: (context, index) {
              final casts = cast[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ImageWithShimmer(
                        imageUrl: casts.profilePath!,
                        width: 130,
                        height: 170,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 140, // Match the poster width
                      child: Text(
                        '${casts.name} - ${casts.character}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
  }
}
