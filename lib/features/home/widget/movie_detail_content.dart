import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/features/home/widget/favorite_button.dart';
import 'package:shartflix/features/profile/view_model/profile_bloc.dart';
import 'package:shartflix/features/profile/view_model/profile_state.dart';
import 'package:shartflix/shared/theme/app_theme.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/widgets/cover_image.dart';

class MovieDetailContent extends StatefulWidget {
  final Movie movie;
  final String movieId;
  final FavoriteButtonContext page;

  const MovieDetailContent({
    super.key,
    required this.movie,
    required this.movieId,
    required this.page,
  });

  @override
  State<MovieDetailContent> createState() => _MovieDetailContentState();
}

class _MovieDetailContentState extends State<MovieDetailContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: context.screenHeight * 0.85,
        maxWidth: context.screenWidth * 0.95,
      ),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha(75),
                  Colors.black.withAlpha(175),
                ],
              ),
            ),
            child: Stack(
              children: [
                if (widget.movie.poster.isNotEmpty)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: CoverImage(
                        images: widget.movie.images,
                        poster: widget.movie.poster,
                      ),
                    ),
                  ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      child: const Icon(Icons.close),
                    ),
                  ),
                ),

                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, profileState) {
                    return buildFavoriteButton(
                      context,
                      widget.movieId,
                      20,
                      widget.movie,
                      widget.page,
                    );
                  },
                ),

                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie.title,
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (widget.movie.year.isNotEmpty) ...[
                            Text(
                              widget.movie.year,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppTheme.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          if (widget.movie.rated.isNotEmpty) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                widget.movie.rated,
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          if (widget.movie.runtime.isNotEmpty)
                            Text(
                              widget.movie.runtime,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppTheme.white,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.movie.imdbRating.isNotEmpty ||
                      widget.movie.metascore.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            context.theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (widget.movie.imdbRating.isNotEmpty)
                            _buildRatingItem(
                              context,
                              context.l10n.imdb,
                              widget.movie.imdbRating,
                              Icons.star,
                              Colors.amber,
                            ),
                          if (widget.movie.metascore.isNotEmpty)
                            _buildRatingItem(
                              context,
                              context.l10n.metascore,
                              widget.movie.metascore,
                              Icons.score,
                              Colors.green,
                            ),
                        ],
                      ),
                    ),

                  if (widget.movie.plot.isNotEmpty) ...[
                    Text(
                      context.l10n.plot,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.movie.plot,
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (widget.movie.genre.isNotEmpty)
                    _buildInfoRow(
                      context,
                      context.l10n.genre,
                      widget.movie.genre,
                    ),

                  if (widget.movie.director.isNotEmpty)
                    _buildInfoRow(
                      context,
                      context.l10n.director,
                      widget.movie.director,
                    ),

                  if (widget.movie.actors.isNotEmpty)
                    _buildInfoRow(
                      context,
                      context.l10n.actors,
                      widget.movie.actors,
                    ),

                  if (widget.movie.writer.isNotEmpty)
                    _buildInfoRow(
                      context,
                      context.l10n.writer,
                      widget.movie.writer,
                    ),

                  if (widget.movie.released.isNotEmpty)
                    _buildInfoRow(
                      context,
                      context.l10n.releaseDate,
                      widget.movie.released,
                    ),

                  if (widget.movie.language.isNotEmpty ||
                      widget.movie.country.isNotEmpty) ...[
                    Row(
                      children: [
                        if (widget.movie.language.isNotEmpty)
                          Expanded(
                            child: _buildInfoRow(
                              context,
                              context.l10n.language,
                              widget.movie.language,
                            ),
                          ),
                        if (widget.movie.country.isNotEmpty)
                          Expanded(
                            child: _buildInfoRow(
                              context,
                              context.l10n.country,
                              widget.movie.country,
                            ),
                          ),
                      ],
                    ),
                  ],

                  if (widget.movie.awards.isNotEmpty)
                    _buildInfoRow(
                      context,
                      context.l10n.awards,
                      widget.movie.awards,
                    ),

                  if (widget.movie.imdbVotes.isNotEmpty)
                    _buildInfoRow(
                      context,
                      context.l10n.imdbVotes,
                      widget.movie.imdbVotes,
                    ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRatingItem(
  BuildContext context,
  String label,
  String value,
  IconData icon,
  Color color,
) {
  return Column(
    children: [
      Icon(icon, color: color, size: 24),
      const SizedBox(height: 4),
      Text(
        label,
        style: context.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        value,
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}

Widget _buildInfoRow(BuildContext context, String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(value, style: context.textTheme.bodyMedium),
      ],
    ),
  );
}
