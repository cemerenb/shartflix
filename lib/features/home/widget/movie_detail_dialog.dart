import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/features/home/view_model/home_bloc.dart';
import 'package:shartflix/features/home/view_model/home_state.dart';
import 'package:shartflix/features/home/widget/favorite_button.dart';
import 'package:shartflix/features/home/widget/movie_detail_content.dart';
import 'package:shartflix/features/profile/view_model/profile_bloc.dart';
import 'package:shartflix/features/profile/view_model/profile_state.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/snackbars/snackbars.dart';

void showMovieDetailDialog(
  BuildContext context,
  String movieId,
  FavoriteButtonContext page,
) async {
  final homeState = context.read<HomeBloc>().state;
  final profileState = context.read<ProfileBloc>().state;

  Movie? movie;

  if (homeState is MovieLoaded) {
    try {
      movie = homeState.movies.firstWhere((m) => m.id == movieId);
    } catch (_) {}
  }

  if (movie == null && profileState is ProfileLoaded) {
    try {
      movie = profileState.favorities.firstWhere((m) => m.id == movieId);
    } catch (_) {}
  }

  if (movie == null) {
    CustomSnackbar.errorSnackbar(
      context: context,
      message: context.l10n.movieNotFound,
    );
    return;
  }

  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: const Color.fromARGB(65, 0, 0, 0),
      child: MovieDetailContent(movie: movie!, movieId: movieId, page: page),
    ),
  );
}
