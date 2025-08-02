import 'package:flutter/material.dart';
import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/features/home/widget/movie_detail_dialog.dart';
import 'package:shartflix/shared/theme/app_theme.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';
import 'package:shartflix/shared/utils/spacers/spacers.dart';

Positioned buildMovieInfo(BuildContext context, Movie movie) {
  return Positioned(
    bottom: context.screenHeight * 0.15,

    left: 16,
    right: 30,
    child: SizedBox(
      width: context.screenWidth - 46,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              showMovieDetailDialog(context, movie);
            },
            child: Text(
              movie.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    color: Colors.black54,
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Image.asset("assets/icon/movie_logo.png", scale: 0.9),
              Spacers.large,
              movie.plot.length > 150
                  ? Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 2,
                                color: AppTheme.white,
                              ),
                            ],
                          ),
                          children: [
                            TextSpan(
                              text: _getTruncatedText(movie.plot),
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppTheme.white,
                              ),
                            ),
                            TextSpan(
                              text: "... ",
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppTheme.white,
                              ),
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  showMovieDetailDialog(context, movie);
                                },
                                child: Text(
                                  context.l10n.seeMore,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: Text(
                        movie.plot,
                        style: context.theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}

String _getTruncatedText(String text) {
  if (text.length <= 80) return text;

  int cutIndex = 80;
  int lastSpace = text.lastIndexOf(' ', cutIndex);

  if (lastSpace > 60) {
    cutIndex = lastSpace;
  }

  return text.substring(0, cutIndex);
}
