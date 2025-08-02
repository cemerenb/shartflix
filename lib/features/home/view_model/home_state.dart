import 'package:equatable/equatable.dart';
import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/features/home/model/pagination.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class MovieInitial extends HomeState {
  const MovieInitial();
}

class MovieLoading extends HomeState {
  const MovieLoading();
}

class MovieLoaded extends HomeState {
  final List<Movie> movies;
  final Pagination pagination;
  final bool isLoadingMore;
  final bool isRefreshing;

  const MovieLoaded({
    required this.movies,
    required this.pagination,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  MovieLoaded copyWith({
    List<Movie>? movies,
    Pagination? pagination,
    bool? isLoadingMore,
    bool? isRefreshing,
  }) {
    return MovieLoaded(
      movies: movies ?? this.movies,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  bool get hasReachedMax => pagination.currentPage >= pagination.maxPage;

  @override
  List<Object?> get props => [movies, pagination, isLoadingMore, isRefreshing];
}

class MovieError extends HomeState {
  final String message;

  const MovieError({required this.message});

  @override
  List<Object?> get props => [message];
}

class MovieFavoriteToggled extends HomeState {
  final String movieId;
  final bool isFavorite;

  const MovieFavoriteToggled({required this.movieId, required this.isFavorite});

  @override
  List<Object?> get props => [movieId, isFavorite];
}
