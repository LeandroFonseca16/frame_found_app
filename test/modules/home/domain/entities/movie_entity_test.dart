import 'package:flutter_test/flutter_test.dart';
import 'package:frame_found_app/modules/home/domain/entities/movie_entity.dart';

void main() {
  group('MovieEntity', () {
    test('should create MovieEntity with all properties', () {
      // Arrange
      const title = 'Batman Begins';
      const year = '2005';
      const imdbId = 'tt0372784';
      const type = 'movie';
      const poster = 'https://example.com/poster.jpg';

      // Act
      final movie = MovieEntity(
        title: title,
        year: year,
        imdbId: imdbId,
        type: type,
        poster: poster,
      );

      // Assert
      expect(movie.title, equals(title));
      expect(movie.year, equals(year));
      expect(movie.imdbId, equals(imdbId));
      expect(movie.type, equals(type));
      expect(movie.poster, equals(poster));
    });

    test('should create MovieEntity with nullable properties', () {
      // Act - title and imdbId are required, others can be null
      final movie = MovieEntity(
        title: 'Batman Begins',
        year: null,
        imdbId: 'tt0372784',
        type: null,
        poster: null,
      );

      // Assert
      expect(movie.title, equals('Batman Begins'));
      expect(movie.year, isNull);
      expect(movie.imdbId, equals('tt0372784'));
      expect(movie.type, isNull);
      expect(movie.poster, isNull);
    });

    test('should handle empty strings', () {
      // Act
      final movie = MovieEntity(
        title: '',
        year: '',
        imdbId: '',
        type: '',
        poster: '',
      );

      // Assert
      expect(movie.title, equals(''));
      expect(movie.year, equals(''));
      expect(movie.imdbId, equals(''));
      expect(movie.type, equals(''));
      expect(movie.poster, equals(''));
    });
  });
}
