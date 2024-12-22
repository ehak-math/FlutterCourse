import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/screen/details_sreen.dart';
import 'package:movie/widgets/movie_lists/slider_card.dart';

class NowPlayingMovie extends StatelessWidget {
  final List<Movie> nowPlayingMovies;

  const  NowPlayingMovie({super.key, required this.nowPlayingMovies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CarouselSlider.builder(
      itemCount: 6,
      options: CarouselOptions(
        viewportFraction: 1,
        height: size.height * 0.55,
        autoPlay: true,
        pageSnapping: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: const Duration(seconds: 1),
      ),
      itemBuilder: (context, index, realIndex) {
        final movie = nowPlayingMovies[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailScreen(movie: movie),),
            );
          },
          child: SliderCard(
            movie: movie,
            itemIndex: index,
          ),
        );
      },
    );
  }
}
