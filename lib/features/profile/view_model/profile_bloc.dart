import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/home/model/movie_model.dart';
import 'package:shartflix/features/profile/repository/profile_repository.dart';
import 'package:shartflix/features/profile/view_model/profile_event.dart';
import 'package:shartflix/features/profile/view_model/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository})
    : super(const ProfileInitial()) {
    on<LoadFavoritiesEvent>(_onLoadFavorities);
  }

  Future<void> _onLoadFavorities(
    LoadFavoritiesEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(const ProfileLoading());
      final List<Movie> favorites = await profileRepository.getFavorites();
      emit(ProfileLoaded(favorities: favorites));
    } catch (e) {
      emit(
        ProfileError(
          message: 'Favoriler yüklenirken hata oluştu: ${e.toString()}',
        ),
      );
    }
  }
}
