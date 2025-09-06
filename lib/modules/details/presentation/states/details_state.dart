import 'package:frame_found_app/modules/details/domain/entities/movie_details_entity.dart';

import '../../../../../shared/core/global_states.dart';

class DetailsState implements GlobalStates {
  const DetailsState({
    this.movieDetails,
  });

  final MovieDetailsEntity? movieDetails;

  DetailsState copyWith({
    MovieDetailsEntity? movieDetails,
  }) {
    return DetailsState(
      movieDetails: movieDetails ?? this.movieDetails,
    );
  }
}