import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/features/home/model/pagination.dart';

class MovieResponseModel {
  final List<Movie> movieList;
  final Pagination pagination;

  MovieResponseModel({required this.movieList, required this.pagination});

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieResponseModel(
      movieList: (json['data']['movies'] as List<dynamic>)
          .map((item) => Movie.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(json['data']['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': movieList.map((movie) => movie.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}
