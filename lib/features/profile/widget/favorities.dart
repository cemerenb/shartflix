import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shartflix/features/home/widget/favorite_button.dart';
import 'package:shartflix/features/home/widget/movie_detail_dialog.dart';
import 'package:shartflix/features/profile/view_model/profile_bloc.dart';
import 'package:shartflix/features/profile/view_model/profile_state.dart';
import 'package:shartflix/shared/theme/app_theme.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/spacers/spacers.dart';
import 'package:shartflix/widgets/cover_image.dart';
import 'package:shartflix/widgets/custom_elevated_button.dart';

class FavoritiesArea extends StatelessWidget {
  const FavoritiesArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.myFavorities,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.push('/favorities');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.seeAll,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppTheme.accentColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            if (profileState is ProfileLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (profileState is ProfileLoaded) {
              final favorites = profileState.favorities;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),

                  if (favorites.isEmpty)
                    SizedBox(
                      width: context.screenWidth,
                      height: context.screenWidth * 0.8,
                      child: Stack(
                        children: [
                          Container(
                            width: context.screenWidth,
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Image.asset(
                              'assets/image/favorities_placeholder.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),

                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  context.l10n.startAddFavorities,
                                  style: context.textTheme.headlineSmall
                                      ?.copyWith(color: AppTheme.white),
                                ),
                                Spacers.verticalMedium,
                                SizedBox(
                                  child: CustomElevatedButton(
                                    onPressed: () {
                                      context.go('/home');
                                    },
                                    child: Text(context.l10n.start),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: favorites.length > 4 ? 4 : favorites.length,
                      itemBuilder: (context, index) {
                        final movie = favorites[index];
                        return GestureDetector(
                          onTap: () {
                            showMovieDetailDialog(
                              context,
                              movie.id,
                              FavoriteButtonContext.profile,
                            );
                          },
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
                              child: CoverImage(
                                images: movie.images,
                                poster: movie.poster,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
