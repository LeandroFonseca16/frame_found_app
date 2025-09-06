import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frame_found_app/modules/home/data/repositories/movies_repository_impl.dart';
import 'package:frame_found_app/modules/home/data/services/remote/movies_service.dart';
import 'package:frame_found_app/modules/home/domain/entities/movie_entity.dart';
import 'package:frame_found_app/shared/core/result.dart';

class MockMovieService extends Mock implements MovieService {}

void main() {
  late MoviesRepositoryImpl repository;
  late MockMovieService mockMovieService;

  setUp(() {
    mockMovieService = MockMovieService();
    repository = MoviesRepositoryImpl(movieService: mockMovieService);
  });

  group('MoviesRepositoryImpl', () {
    const query = 'batman';
    final mockMovies = [
      MovieEntity(
        title: 'Batman Begins',
        year: '2005',
        imdbId: 'tt0372784',
        type: 'movie',
        poster: 'https://example.com/poster.jpg',
      ),
      MovieEntity(
        title: 'The Dark Knight',
        year: '2008',
        imdbId: 'tt0468569',
        type: 'movie',
        poster: 'https://example.com/poster2.jpg',
      ),
    ];

    group('searchMovies', () {
      test('should return Success when service returns success', () async {
        // Arrange
        when(() => mockMovieService.searchMovies(query: query))
            .thenAnswer((_) async => Success<List<MovieEntity>, String>(mockMovies));

        // Act
        final result = await repository.searchMovies(query: query);

        // Assert
        expect(result, isA<Success<List<MovieEntity>, String>>());
        expect(result.getOrNull(), equals(mockMovies));
        verify(() => mockMovieService.searchMovies(query: query)).called(1);
      });

      test('should return Failure when service returns failure', () async {
        // Arrange
        const errorMessage = 'Network error';
        when(() => mockMovieService.searchMovies(query: query))
            .thenAnswer((_) async => Failure<List<MovieEntity>, String>(errorMessage));

        // Act
        final result = await repository.searchMovies(query: query);

        // Assert
        expect(result, isA<Failure<List<MovieEntity>, String>>());
        expect(result.getOrNullFailure(), equals(errorMessage));
        verify(() => mockMovieService.searchMovies(query: query)).called(1);
      });

      test('should return Failure when query is empty', () async {
        // Act
        final result = await repository.searchMovies(query: '');

        // Assert
        expect(result, isA<Failure<List<MovieEntity>, String>>());
        expect(result.getOrNullFailure(), equals('Termo de busca não pode ser vazio'));
        verifyNever(() => mockMovieService.searchMovies(query: any(named: 'query')));
      });

      test('should return Failure when service throws exception', () async {
        // Arrange
        when(() => mockMovieService.searchMovies(query: query))
            .thenThrow(Exception('Connection timeout'));

        // Act
        final result = await repository.searchMovies(query: query);

        // Assert
        expect(result, isA<Failure<List<MovieEntity>, String>>());
        expect(result.getOrNullFailure(), contains('Erro ao buscar filmes: Exception: Connection timeout'));
        verify(() => mockMovieService.searchMovies(query: query)).called(1);
      });

      test('should handle null query gracefully', () async {
        // Act
        final result = await repository.searchMovies(query: '');

        // Assert
        expect(result, isA<Failure<List<MovieEntity>, String>>());
        expect(result.getOrNullFailure(), equals('Termo de busca não pode ser vazio'));
      });
    });
  });
}
