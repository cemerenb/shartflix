import 'package:flutter/material.dart';
import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/widgets/cover_image.dart';

Widget buildMoviePage(BuildContext context, Movie movie) {
  return Stack(
    children: [
      Positioned.fill(
        child: CoverImage(images: movie.images, poster: movie.poster),
      ),
    ],
  );
}
