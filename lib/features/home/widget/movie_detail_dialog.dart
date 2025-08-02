import 'package:flutter/material.dart';
import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/widgets/cover_image.dart';

void showMovieDetailDialog(BuildContext context, Movie movie) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: const Color.fromARGB(65, 0, 0, 0),
      child: Container(
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
              height: 200,
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
                  if (movie.poster.isNotEmpty)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: CoverImage(
                          images: movie.images,
                          poster: movie.poster,
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

                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (movie.year.isNotEmpty) ...[
                              Text(
                                movie.year,
                                style: context.textTheme.bodyMedium,
                              ),
                              const SizedBox(width: 8),
                            ],
                            if (movie.rated.isNotEmpty) ...[
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
                                  movie.rated,
                                  style: context.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                            if (movie.runtime.isNotEmpty)
                              Text(
                                movie.runtime,
                                style: context.textTheme.bodyMedium?.copyWith(),
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
                    if (movie.imdbRating.isNotEmpty ||
                        movie.metascore.isNotEmpty)
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
                            if (movie.imdbRating.isNotEmpty)
                              _buildRatingItem(
                                context,
                                context.l10n.imdb,
                                movie.imdbRating,
                                Icons.star,
                                Colors.amber,
                              ),
                            if (movie.metascore.isNotEmpty)
                              _buildRatingItem(
                                context,
                                context.l10n.metascore,
                                movie.metascore,
                                Icons.score,
                                Colors.green,
                              ),
                          ],
                        ),
                      ),

                    if (movie.plot.isNotEmpty) ...[
                      Text(
                        context.l10n.plot,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.plot,
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 16),
                    ],

                    if (movie.genre.isNotEmpty)
                      _buildInfoRow(context, context.l10n.genre, movie.genre),

                    if (movie.director.isNotEmpty)
                      _buildInfoRow(
                        context,
                        context.l10n.director,
                        movie.director,
                      ),

                    if (movie.actors.isNotEmpty)
                      _buildInfoRow(context, context.l10n.actors, movie.actors),

                    if (movie.writer.isNotEmpty)
                      _buildInfoRow(context, context.l10n.writer, movie.writer),

                    if (movie.released.isNotEmpty)
                      _buildInfoRow(
                        context,
                        context.l10n.releaseDate,
                        movie.released,
                      ),

                    if (movie.language.isNotEmpty ||
                        movie.country.isNotEmpty) ...[
                      Row(
                        children: [
                          if (movie.language.isNotEmpty)
                            Expanded(
                              child: _buildInfoRow(
                                context,
                                context.l10n.language,
                                movie.language,
                              ),
                            ),
                          if (movie.country.isNotEmpty)
                            Expanded(
                              child: _buildInfoRow(
                                context,
                                context.l10n.country,
                                movie.country,
                              ),
                            ),
                        ],
                      ),
                    ],

                    if (movie.awards.isNotEmpty)
                      _buildInfoRow(context, context.l10n.awards, movie.awards),

                    if (movie.imdbVotes.isNotEmpty)
                      _buildInfoRow(
                        context,
                        context.l10n.imdbVotes,
                        movie.imdbVotes,
                      ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
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
