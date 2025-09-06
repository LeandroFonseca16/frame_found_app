import 'package:flutter_test/flutter_test.dart';
import 'package:frame_found_app/modules/details/domain/entities/movie_details_entity.dart';
import 'package:frame_found_app/modules/details/data/dtos/movie_details_dto.dart';

void main() {
  group('MovieDetailsDto', () {
    const mockMovieDetailsMap = {
      'Title': 'Batman Begins',
      'Year': '2005',
      'Rated': 'PG-13',
      'Released': '15 Jun 2005',
      'Runtime': '140 min',
      'Genre': 'Action, Crime, Drama',
      'Director': 'Christopher Nolan',
      'Writer': 'Bob Kane, David S. Goyer, Christopher Nolan',
      'Actors': 'Christian Bale, Michael Caine, Ken Watanabe',
      'Plot': 'After training with his mentor, Batman begins his fight to free crime-ridden Gotham City from corruption.',
      'Language': 'English, Mandarin',
      'Country': 'United States, United Kingdom',
      'Awards': 'Nominated for 1 Oscar. 15 wins & 79 nominations total',
      'Poster': 'https://example.com/poster.jpg',
      'imdbRating': '8.2',
      'imdbVotes': '1,400,000',
      'imdbID': 'tt0372784',
      'Type': 'movie',
      'BoxOffice': '\$374,218,673',
      'Production': 'Warner Bros. Pictures',
      'Website': 'http://www.batmanbegins.com/',
    };

    final mockMovieDetailsEntity = MovieDetailsEntity(
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

    test('should convert MovieDetailsEntity to Map correctly', () {
      // Act
      final result = mockMovieDetailsEntity.toMap();

      // Assert
      expect(result, equals(mockMovieDetailsMap));
      expect(result['Title'], equals('Batman Begins'));
      expect(result['Director'], equals('Christopher Nolan'));
      expect(result['imdbRating'], equals('8.2'));
    });

    test('should convert Map to MovieDetailsEntity correctly', () {
      // Act
      final result = MovieDetailsDto.fromMap(mockMovieDetailsMap);

      // Assert
      expect(result.title, equals(mockMovieDetailsEntity.title));
      expect(result.director, equals(mockMovieDetailsEntity.director));
      expect(result.imdbRating, equals(mockMovieDetailsEntity.imdbRating));
      expect(result.plot, equals(mockMovieDetailsEntity.plot));
    });

    test('should handle null values in Map', () {
      // Arrange
      const mapWithNulls = {
        'Title': null,
        'Year': null,
        'Rated': null,
        'Released': null,
        'Runtime': null,
        'Genre': null,
        'Director': null,
        'Writer': null,
        'Actors': null,
        'Plot': null,
        'Language': null,
        'Country': null,
        'Awards': null,
        'Poster': null,
        'imdbRating': null,
        'imdbVotes': null,
        'imdbID': null,
        'Type': null,
        'BoxOffice': null,
        'Production': null,
        'Website': null,
      };

      // Act
      final result = MovieDetailsDto.fromMap(mapWithNulls);

      // Assert
      expect(result.title, isNull);
      expect(result.director, isNull);
      expect(result.imdbRating, isNull);
      expect(result.plot, isNull);
    });

    test('should handle missing keys in Map', () {
      // Arrange
      const incompleteMap = <String, dynamic>{
        'Title': 'Batman Begins',
        'Director': 'Christopher Nolan',
        // Missing other keys
      };

      // Act
      final result = MovieDetailsDto.fromMap(incompleteMap);

      // Assert
      expect(result.title, equals('Batman Begins'));
      expect(result.director, equals('Christopher Nolan'));
      expect(result.year, isNull);
      expect(result.plot, isNull);
    });
  });
}
