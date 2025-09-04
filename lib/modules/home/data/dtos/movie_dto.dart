import '../../domain/entities/movie_entity.dart';

extension MovieDto on MovieEntity {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "Title": title,
      "Year": year,
      "imdbID": imdbId,
      "Type": type,
      "Poster": poster,
    };
  }

  static MovieEntity fromMap(Map<String, dynamic> map) {
    return MovieEntity(
      title: map["Title"],
      year: map["Year"],
      imdbId: map["imdbID"],
      type: map["Type"],
      poster: map["Poster"],
    );
  }

  static List<MovieEntity> fromList(Iterable? list) {
    if(list == null) return [];
    return list.map((e) => fromMap(e)).toList();
  }
}
