import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/features/home/view_model/home_bloc.dart';
import 'package:shartflix/features/home/view_model/home_event.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

Positioned buildFavoriteButton(BuildContext context, Movie movie) {
  void toggleFavorite(String movieId) {
    context.read<HomeBloc>().add(ToggleFavoriteEvent(movieId: movieId));
  }

  return Positioned(
    bottom: context.screenHeight * 0.25,
    right: 16,
    child: GestureDetector(
      onTap: () => toggleFavorite(movie.id),
      child: Container(
        width: 50,
        height: 80,
        decoration: BoxDecoration(
          color: movie.isFavorite
              ? context.theme.colorScheme.secondary
              : Colors.black.withAlpha(100),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withAlpha(75), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (movie.isFavorite) ...[
              const Icon(Icons.favorite, color: Colors.white, size: 28),
            ] else ...[
              const Icon(Icons.favorite_border, color: Colors.white, size: 28),
            ],
          ],
        ),
      ),
    ),
  );
}
