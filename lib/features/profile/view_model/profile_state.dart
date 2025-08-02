import 'package:equatable/equatable.dart';
import 'package:shartflix/features/home/model/movie_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoaded extends ProfileState {
  final List<Movie> favorities;
  const ProfileLoaded({required this.favorities});

  ProfileLoaded copyWith({List<Movie>? favorities}) {
    return ProfileLoaded(favorities: favorities ?? this.favorities);
  }

  @override
  List<Object> get props => [favorities];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}
