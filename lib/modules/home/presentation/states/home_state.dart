import 'package:frame_found_app/modules/home/domain/entities/movie_entity.dart';

import '../../../../../shared/core/global_states.dart';

class HomeState implements GlobalStates {
  const HomeState({
    this.localizedFilms,
  });

  final List<MovieEntity>? localizedFilms;

  HomeState copyWith({
    List<MovieEntity>? localizedFilms,
  }) {
    return HomeState(
      localizedFilms: localizedFilms ?? this.localizedFilms,
    );
  }
}
