import 'package:equatable/equatable.dart';
import 'package:shartflix/features/home/model/movie_model.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoritiesEvent extends ProfileEvent {
  final List<Movie> favorities;
  const LoadFavoritiesEvent({required this.favorities});

  @override
  List<Object> get props => [favorities];
}
