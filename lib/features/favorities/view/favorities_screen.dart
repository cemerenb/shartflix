import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/features/home/widget/favorite_button.dart';
import 'package:shartflix/features/home/widget/movie_detail_dialog.dart';
import 'package:shartflix/features/profile/view_model/profile_bloc.dart';
import 'package:shartflix/features/profile/view_model/profile_state.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/widgets/cover_image.dart';

class FavoritiesScreen extends StatelessWidget {
  const FavoritiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_rounded),
        ),
        title: Text(context.l10n.myFavorities),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, profileState) {
          if (profileState is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (profileState is ProfileLoaded) {
            final favorites = profileState.favorities;

            if (favorites.isEmpty) {
              return Center(
                child: Text(
                  context.l10n.noFavorities,
                  style: context.textTheme.titleLarge,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: FavoritiesGrid(favorites: favorites),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class FavoritiesGrid extends StatelessWidget {
  const FavoritiesGrid({super.key, required this.favorites});

  final List<Movie> favorites;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final movie = favorites[index];
        return GestureDetector(
          onTap: () => showMovieDetailDialog(
            context,
            movie.id,
            FavoriteButtonContext.profile,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CoverImage(images: movie.images, poster: movie.poster),
            ),
          ),
        );
      },
    );
  }
}
