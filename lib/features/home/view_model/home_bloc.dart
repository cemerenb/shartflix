import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/features/home/model/pagination.dart';
import 'package:shartflix/features/home/repository/home_repository.dart';
import 'package:shartflix/features/home/view_model/home_event.dart';
import 'package:shartflix/features/home/view_model/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  List<Movie> _allMovies = [];
  Pagination? _currentPagination;

  HomeBloc({required this.homeRepository}) : super(const MovieInitial()) {
    on<LoadMoviesEvent>(_onLoadMovies);
    on<LoadMoreMoviesEvent>(_onLoadMoreMovies);
    on<RefreshMoviesEvent>(_onRefreshMovies);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadMovies(
    LoadMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (event.isRefresh && _allMovies.isNotEmpty) {
        emit(
          MovieLoaded(
            movies: _allMovies,
            pagination: _currentPagination!,
            isRefreshing: true,
          ),
        );
      } else {
        emit(const MovieLoading());
      }

      final response = await homeRepository.getMovies(page: event.page);

      if (event.isRefresh || event.page == 1) {
        _allMovies = response.movieList;
      } else {
        _allMovies.addAll(response.movieList);
      }

      _currentPagination = response.pagination;

      emit(
        MovieLoaded(
          movies: List.from(_allMovies),
          pagination: _currentPagination!,
          isRefreshing: false,
        ),
      );
    } catch (e) {
      emit(MovieError(message: e.toString()));
    }
  }

  Future<void> _onLoadMoreMovies(
    LoadMoreMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is MovieLoaded && !currentState.isLoadingMore) {
      try {
        emit(currentState.copyWith(isLoadingMore: true));

        int pageToLoad;

        if (currentState.hasReachedMax) {
          pageToLoad = 1;
        } else {
          pageToLoad = currentState.pagination.currentPage + 1;
        }

        final response = await homeRepository.getMovies(page: pageToLoad);

        final updatedMovies = [..._allMovies, ...response.movieList];
        _allMovies = updatedMovies;
        _currentPagination = response.pagination;

        emit(
          MovieLoaded(
            movies: List.from(_allMovies),
            pagination: _currentPagination!,
            isLoadingMore: false,
          ),
        );
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
        emit(MovieError(message: e.toString()));
      }
    }
  }

  Future<void> _onRefreshMovies(
    RefreshMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    add(const LoadMoviesEvent(page: 1, isRefresh: true));
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final movieIndex = _allMovies.indexWhere(
        (movie) => movie.id == event.movieId,
      );

      if (movieIndex != -1) {
        Movie favoriteMovie = await homeRepository.toggleFavorite(
          event.movieId,
        );
        _allMovies[movieIndex] = favoriteMovie;

        final currentState = state;
        if (currentState is MovieLoaded) {
          emit(
            MovieFavoriteToggled(
              movieId: event.movieId,
              isFavorite: favoriteMovie.isFavorite,
            ),
          );

          emit(currentState.copyWith(movies: List.from(_allMovies)));
        }
      }
    } catch (e) {
      emit(MovieError(message: e.toString()));
    }
  }
}
