import 'package:flutter_test/flutter_test.dart';
import 'package:frame_found_app/modules/details/domain/entities/movie_details_entity.dart';

void main() {
  group('MovieDetailsEntity', () {
    test('should create MovieDetailsEntity with all properties', () {
      // Arrange
      const title = 'Batman Begins';
      const year = '2005';
      const rated = 'PG-13';
      const released = '15 Jun 2005';
      const runtime = '140 min';
      const genre = 'Action, Crime, Drama';
      const director = 'Christopher Nolan';
      const writer = 'Bob Kane, David S. Goyer, Christopher Nolan';
      const actors = 'Christian Bale, Michael Caine, Ken Watanabe';
      const plot = 'After training with his mentor, Batman begins his fight to free crime-ridden Gotham City from corruption.';
      const language = 'English, Mandarin';
      const country = 'United States, United Kingdom';
      const awards = 'Nominated for 1 Oscar. 15 wins & 79 nominations total';
      const poster = 'https://example.com/poster.jpg';
      const imdbRating = '8.2';
      const imdbVotes = '1,400,000';
      const imdbId = 'tt0372784';
      const type = 'movie';
      const boxOffice = '\$374,218,673';
      const production = 'Warner Bros. Pictures';
      const website = 'http://www.batmanbegins.com/';

      // Act
      final movieDetails = MovieDetailsEntity(
        title: title,
        year: year,
        rated: rated,
        released: released,
        runtime: runtime,
        genre: genre,
        director: director,
        writer: writer,
        actors: actors,
        plot: plot,
        language: language,
        country: country,
        awards: awards,
        poster: poster,
        imdbRating: imdbRating,
        imdbVotes: imdbVotes,
        imdbId: imdbId,
        type: type,
        boxOffice: boxOffice,
        production: production,
        website: website,
      );

      // Assert
      expect(movieDetails.title, equals(title));
      expect(movieDetails.year, equals(year));
      expect(movieDetails.rated, equals(rated));
      expect(movieDetails.released, equals(released));
      expect(movieDetails.runtime, equals(runtime));
      expect(movieDetails.genre, equals(genre));
      expect(movieDetails.director, equals(director));
      expect(movieDetails.writer, equals(writer));
      expect(movieDetails.actors, equals(actors));
      expect(movieDetails.plot, equals(plot));
      expect(movieDetails.language, equals(language));
      expect(movieDetails.country, equals(country));
      expect(movieDetails.awards, equals(awards));
      expect(movieDetails.poster, equals(poster));
      expect(movieDetails.imdbRating, equals(imdbRating));
      expect(movieDetails.imdbVotes, equals(imdbVotes));
      expect(movieDetails.imdbId, equals(imdbId));
      expect(movieDetails.type, equals(type));
      expect(movieDetails.boxOffice, equals(boxOffice));
      expect(movieDetails.production, equals(production));
      expect(movieDetails.website, equals(website));
    });

    test('should create MovieDetailsEntity with null properties', () {
      // Act
      final movieDetails = MovieDetailsEntity(
        title: null,
        year: null,
        rated: null,
        released: null,
        runtime: null,
        genre: null,
        director: null,
        writer: null,
        actors: null,
        plot: null,
        language: null,
        country: null,
        awards: null,
        poster: null,
        imdbRating: null,
        imdbVotes: null,
        imdbId: null,
        type: null,
        boxOffice: null,
        production: null,
        website: null,
      );

      // Assert
      expect(movieDetails.title, isNull);
      expect(movieDetails.year, isNull);
      expect(movieDetails.rated, isNull);
      expect(movieDetails.released, isNull);
      expect(movieDetails.runtime, isNull);
      expect(movieDetails.genre, isNull);
      expect(movieDetails.director, isNull);
      expect(movieDetails.writer, isNull);
      expect(movieDetails.actors, isNull);
      expect(movieDetails.plot, isNull);
      expect(movieDetails.language, isNull);
      expect(movieDetails.country, isNull);
      expect(movieDetails.awards, isNull);
      expect(movieDetails.poster, isNull);
      expect(movieDetails.imdbRating, isNull);
      expect(movieDetails.imdbVotes, isNull);
      expect(movieDetails.imdbId, isNull);
      expect(movieDetails.type, isNull);
      expect(movieDetails.boxOffice, isNull);
      expect(movieDetails.production, isNull);
      expect(movieDetails.website, isNull);
    });
  });
}
