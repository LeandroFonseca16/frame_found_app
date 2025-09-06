import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frame_found_app/modules/details/data/repositories/movie_details_repository_impl.dart';
import 'package:frame_found_app/modules/details/data/services/remote/movie_details_service.dart';
import 'package:frame_found_app/modules/details/domain/entities/movie_details_entity.dart';
import 'package:frame_found_app/shared/core/result.dart';

class MockMovieDetailsService extends Mock implements MovieDetailsService {}

void main() {
  late MovieDetailsRepositoryImpl repository;
  late MockMovieDetailsService mockMovieDetailsService;

  setUp(() {
    mockMovieDetailsService = MockMovieDetailsService();
    repository = MovieDetailsRepositoryImpl(movieDetailsService: mockMovieDetailsService);
  });

  group('MovieDetailsRepositoryImpl', () {
    const imdbId = 'tt0372784';
    final mockMovieDetails = MovieDetailsEntity(
      title: 'Batman Begins',
      year: '2005',
      rated: 'PG-13',
      released: '15 Jun 2005',
      runtime: '140 min',
      genre: 'Action, Crime, Drama',
      director: 'Christopher Nolan',
      writer: 'Bob Kane, David S. Goyer, Christopher Nolan',
      actors: 'Christian Bale, Michael Caine, Ken Watanabe',
      plot: 'After training with his mentor, Batman begins his fight to free crime-ridden Gotham City from corruption.',
      language: 'English, Mandarin',
      country: 'United States, United Kingdom',
      awards: 'Nominated for 1 Oscar. 15 wins & 79 nominations total',
      poster: 'https://example.com/poster.jpg',
      imdbRating: '8.2',
      imdbVotes: '1,400,000',
      imdbId: 'tt0372784',
      type: 'movie',
      boxOffice: '\$374,218,673',
      production: 'Warner Bros. Pictures',
      website: 'http://www.batmanbegins.com/',
    );

    group('getMovieDetails', () {
      test('should return Success when service returns success', () async {
        // Arrange
        when(() => mockMovieDetailsService.getMovieDetails(imdbId: imdbId))
            .thenAnswer((_) async => Success<MovieDetailsEntity, String>(mockMovieDetails));

        // Act
        final result = await repository.getMovieDetails(imdbId: imdbId);

        // Assert
        expect(result, isA<Success<MovieDetailsEntity, String>>());
        expect(result.getOrNull(), equals(mockMovieDetails));
        verify(() => mockMovieDetailsService.getMovieDetails(imdbId: imdbId)).called(1);
      });

      test('should return Failure when service returns failure', () async {
        // Arrange
        const errorMessage = 'Movie not found';
        when(() => mockMovieDetailsService.getMovieDetails(imdbId: imdbId))
            .thenAnswer((_) async => Failure<MovieDetailsEntity, String>(errorMessage));

        // Act
        final result = await repository.getMovieDetails(imdbId: imdbId);

        // Assert
        expect(result, isA<Failure<MovieDetailsEntity, String>>());
        expect(result.getOrNullFailure(), equals(errorMessage));
        verify(() => mockMovieDetailsService.getMovieDetails(imdbId: imdbId)).called(1);
      });

      test('should return Failure when imdbId is empty', () async {
        // Act
        final result = await repository.getMovieDetails(imdbId: '');

        // Assert
        expect(result, isA<Failure<MovieDetailsEntity, String>>());
        expect(result.getOrNullFailure(), equals('ID do filme não pode ser vazio'));
        verifyNever(() => mockMovieDetailsService.getMovieDetails(imdbId: any(named: 'imdbId')));
      });

      test('should return Failure when service throws exception', () async {
        // Arrange
        when(() => mockMovieDetailsService.getMovieDetails(imdbId: imdbId))
            .thenThrow(Exception('Network timeout'));

        // Act
        final result = await repository.getMovieDetails(imdbId: imdbId);

        // Assert
        expect(result, isA<Failure<MovieDetailsEntity, String>>());
        expect(result.getOrNullFailure(), contains('Erro ao buscar detalhes do filme: Exception: Network timeout'));
        verify(() => mockMovieDetailsService.getMovieDetails(imdbId: imdbId)).called(1);
      });
    });
  });
}
