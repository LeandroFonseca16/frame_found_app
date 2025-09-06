import '../../domain/entities/movie_details_entity.dart';

extension MovieDetailsDto on MovieDetailsEntity {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "Title": title,
      "Year": year,
      "Rated": rated,
      "Released": released,
      "Runtime": runtime,
      "Genre": genre,
      "Director": director,
      "Writer": writer,
      "Actors": actors,
      "Plot": plot,
      "Language": language,
      "Country": country,
      "Awards": awards,
      "Poster": poster,
      "imdbRating": imdbRating,
      "imdbVotes": imdbVotes,
      "imdbID": imdbId,
      "Type": type,
      "BoxOffice": boxOffice,
      "Production": production,
      "Website": website,
    };
  }

  static MovieDetailsEntity fromMap(Map<String, dynamic> map) {
    return MovieDetailsEntity(
      title: map["Title"],
      year: map["Year"],
      rated: map["Rated"],
      released: map["Released"],
      runtime: map["Runtime"],
      genre: map["Genre"],
      director: map["Director"],
      writer: map["Writer"],
      actors: map["Actors"],
      plot: map["Plot"],
      language: map["Language"],
      country: map["Country"],
      awards: map["Awards"],
      poster: map["Poster"],
      imdbRating: map["imdbRating"],
      imdbVotes: map["imdbVotes"],
      imdbId: map["imdbID"],
      type: map["Type"],
      boxOffice: map["BoxOffice"],
      production: map["Production"],
      website: map["Website"],
    );
  }
}
