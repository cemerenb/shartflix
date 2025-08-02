import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/features/home/view_model/home_bloc.dart';
import 'package:shartflix/features/home/view_model/home_event.dart';
import 'package:shartflix/features/home/view_model/home_state.dart';
import 'package:shartflix/features/profile/view_model/profile_bloc.dart';
import 'package:shartflix/features/profile/view_model/profile_event.dart';
import 'package:shartflix/features/profile/view_model/profile_state.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

enum FavoriteButtonContext { home, profile }

Widget buildFavoriteButton(
  BuildContext context,
  String movieId,
  double bottom,
  Movie? selectedMovie,
  FavoriteButtonContext buttonContext,
) {
  if (buttonContext == FavoriteButtonContext.profile) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        Movie movie = selectedMovie!;
        if (state is! ProfileLoaded) return const SizedBox.shrink();
        try {
          movie = state.favorities.firstWhere(
            (element) => element.id == movieId,
          );
        } catch (e) {}

        return Positioned(
          bottom: bottom,
          right: 16,
          child: GestureDetector(
            onTap: () async {
              context.read<HomeBloc>().add(
                ToggleFavoriteEvent(movieId: movie.id),
              );
              final profileBloc = context.read<ProfileBloc>();
              final repository = profileBloc.profileRepository;
              final updatedFavorites = await repository.getFavorites();
              if (context.mounted) {
                context.read<ProfileBloc>().add(
                  LoadFavoritiesEvent(favorities: updatedFavorites),
                );
                context.pop();
              }
            },
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
              child: Icon(
                movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        );
      },
    );
  } else {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is! MovieLoaded) return const SizedBox.shrink();

        final movie = state.movies.firstWhere((m) => m.id == movieId);

        return Positioned(
          bottom: bottom,
          right: 16,
          child: GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(
                ToggleFavoriteEvent(movieId: movie.id),
              );
            },
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
              child: Icon(
                movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        );
      },
    );
  }
}
