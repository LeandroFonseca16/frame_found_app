import 'package:flutter_test/flutter_test.dart';
import 'package:frame_found_app/modules/home/domain/entities/movie_entity.dart';
import 'package:frame_found_app/modules/home/data/dtos/movie_dto.dart';

void main() {
  group('MovieDto', () {
    const mockMovieMap = {
      'Title': 'Batman Begins',
      'Year': '2005',
      'imdbID': 'tt0372784',
      'Type': 'movie',
      'Poster': 'https://example.com/poster.jpg',
    };

    final mockMovieEntity = MovieEntity(
      title: 'Batman Begins',
      year: '2005',
      imdbId: 'tt0372784',
      type: 'movie',
      poster: 'https://example.com/poster.jpg',
    );

    test('should convert MovieEntity to Map correctly', () {
      // Act
      final result = mockMovieEntity.toMap();

      // Assert
      expect(result, equals(mockMovieMap));
      expect(result['Title'], equals('Batman Begins'));
      expect(result['Year'], equals('2005'));
      expect(result['imdbID'], equals('tt0372784'));
      expect(result['Type'], equals('movie'));
      expect(result['Poster'], equals('https://example.com/poster.jpg'));
    });

    test('should convert Map to MovieEntity correctly', () {
      // Act
      final result = MovieDto.fromMap(mockMovieMap);

      // Assert
      expect(result.title, equals(mockMovieEntity.title));
      expect(result.year, equals(mockMovieEntity.year));
      expect(result.imdbId, equals(mockMovieEntity.imdbId));
      expect(result.type, equals(mockMovieEntity.type));
      expect(result.poster, equals(mockMovieEntity.poster));
    });

    test('should handle null values in Map', () {
      // Arrange
      const mapWithNulls = {
        'Title': null,
        'Year': null,
        'imdbID': null,
        'Type': null,
        'Poster': null,
      };

      // Act
      final result = MovieDto.fromMap(mapWithNulls);

      // Assert
      expect(result.title, equals('')); // title gets empty string as default
      expect(result.year, isNull);
      expect(result.imdbId, equals('')); // imdbId gets empty string as default
      expect(result.type, isNull);
      expect(result.poster, isNull);
    });

    test('should handle missing keys in Map', () {
      // Arrange
      const incompleteMap = <String, dynamic>{
        'Title': 'Batman Begins',
        // Missing other keys
      };

      // Act
      final result = MovieDto.fromMap(incompleteMap);

      // Assert
      expect(result.title, equals('Batman Begins'));
      expect(result.year, isNull);
      expect(result.imdbId, equals('')); // imdbId gets empty string as default
      expect(result.type, isNull);
      expect(result.poster, isNull);
    });

    test('should convert list of maps to list of MovieEntity', () {
      // Arrange
      final moviesList = [
        mockMovieMap,
        {
          'Title': 'The Dark Knight',
          'Year': '2008',
          'imdbID': 'tt0468569',
          'Type': 'movie',
          'Poster': 'https://example.com/poster2.jpg',
        }
      ];

      // Act
      final result = MovieDto.fromList(moviesList);

      // Assert
      expect(result, hasLength(2));
      expect(result[0].title, equals('Batman Begins'));
      expect(result[1].title, equals('The Dark Knight'));
    });

    test('should return empty list when input is null', () {
      // Act
      final result = MovieDto.fromList(null);

      // Assert
      expect(result, isEmpty);
    });

    test('should return empty list when input is empty', () {
      // Act
      final result = MovieDto.fromList([]);

      // Assert
      expect(result, isEmpty);
    });
  });
}
