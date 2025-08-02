import 'dart:developer';

import 'package:flutter/material.dart';

class CoverImage extends StatefulWidget {
  final List<String> images;
  final String poster;
  const CoverImage({super.key, required this.images, required this.poster});

  @override
  State<CoverImage> createState() => _CoverImageState();
}

class _CoverImageState extends State<CoverImage> {
  @override
  Widget build(BuildContext context) {
    return widget.poster == ""
        ? Image.network(
            widget.images.first,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return widget.poster.isNotEmpty
                  ? Image.network(
                      widget.poster,
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[900],
                          child: const Icon(
                            Icons.movie,
                            size: 100,
                            color: Colors.white54,
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[900],
                      child: const Icon(
                        Icons.movie,
                        size: 100,
                        color: Colors.white54,
                      ),
                    );
            },
          )
        : widget.poster != ""
        ? Image.network(
            widget.poster,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              log(error.toString());
              return Container(
                color: Colors.grey[900],
                child: const Icon(
                  Icons.movie,
                  size: 100,
                  color: Colors.white54,
                ),
              );
            },
          )
        : Container(
            color: Colors.grey[900],
            child: const Icon(Icons.movie, size: 100, color: Colors.white54),
          );
  }
}
