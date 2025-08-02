import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadMoviesEvent extends HomeEvent {
  final int page;
  final bool isRefresh;

  const LoadMoviesEvent({this.page = 1, this.isRefresh = false});

  @override
  List<Object?> get props => [page, isRefresh];
}

class LoadMoreMoviesEvent extends HomeEvent {
  const LoadMoreMoviesEvent();
}

class RefreshMoviesEvent extends HomeEvent {
  const RefreshMoviesEvent();
}

class ToggleFavoriteEvent extends HomeEvent {
  final String movieId;

  const ToggleFavoriteEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}
