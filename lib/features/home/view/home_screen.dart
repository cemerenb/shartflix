import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/auth/view_model/auth_bloc.dart';
import 'package:shartflix/features/auth/view_model/auth_state.dart';
import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/features/home/view/favorite_button.dart';
import 'package:shartflix/features/home/view_model/home_bloc.dart';
import 'package:shartflix/features/home/view_model/home_event.dart';
import 'package:shartflix/features/home/view_model/home_state.dart';
import 'package:shartflix/features/home/widget/bottom_gradient.dart';
import 'package:shartflix/features/home/widget/favorite_popup.dart';
import 'package:shartflix/features/home/widget/movie_canvas.dart';
import 'package:shartflix/features/home/widget/movie_info.dart';
import 'package:shartflix/shared/theme/app_theme.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController favoriteAnimationController;
  int movieIndex = 0;
  bool showFavoritePopup = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    favoriteAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const LoadMoviesEvent());
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    favoriteAnimationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    final movieState = context.read<HomeBloc>().state;
    if (movieState is MovieLoaded) {
      if (index >= movieState.movies.length - 2 &&
          !movieState.isLoadingMore &&
          !movieState.hasReachedMax) {
        context.read<HomeBloc>().add(const LoadMoreMoviesEvent());
      }
      if (movieState.hasReachedMax) {
        context.read<HomeBloc>().add(const LoadMoreMoviesEvent());
      }
    }
    movieIndex = index;
    setState(() {});
  }

  void _onRefresh() {
    context.read<HomeBloc>().add(const RefreshMoviesEvent());
  }

  void showFavoriteAnimation() async {
    setState(() {
      showFavoritePopup = true;
    });

    await favoriteAnimationController.forward(from: 0);
    await Future.delayed(const Duration(milliseconds: 200));
    await favoriteAnimationController.reverse();

    setState(() {
      showFavoritePopup = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is AuthAuthenticated) {
            return BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is MovieFavoriteToggled && state.isFavorite) {
                  showFavoriteAnimation();
                }
              },
              builder: (context, movieState) {
                if (movieState is MovieLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (movieState is MovieError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${context.l10n.error} ${movieState.message}',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<HomeBloc>().add(
                              const LoadMoviesEvent(),
                            );
                          },
                          child: Text(context.l10n.retry),
                        ),
                      ],
                    ),
                  );
                }

                if (movieState is MovieLoaded && movieState.movies.isEmpty) {
                  return Center(child: Text(context.l10n.noMoviesFound));
                }

                if (movieState is MovieLoaded) {
                  Movie movie = movieState.movies.first;
                  return RefreshIndicator(
                    onRefresh: () async {
                      _onRefresh();
                    },
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.vertical,
                          onPageChanged: _onPageChanged,
                          itemCount: movieState.movies.length,
                          itemBuilder: (context, index) {
                            movie = movieState.movies[index];
                            return buildMoviePage(context, movie);
                          },
                        ),

                        buildFavoritePopup(
                          context,
                          showFavoritePopup,
                          favoriteAnimationController,
                        ),
                        buildBottomGradient(context),
                        buildMovieInfo(context, movieState.movies[movieIndex]),
                        buildFavoriteButton(
                          context,
                          movieState.movies[movieIndex],
                        ),

                        if (movieState.isLoadingMore)
                          const Positioned(
                            top: 50,
                            left: 0,
                            right: 0,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
