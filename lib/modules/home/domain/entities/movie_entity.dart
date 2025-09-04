class MovieEntity {
  MovieEntity({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.type,
    required this.poster,
  });

  final String? title;
  final String? year;
  final String? imdbId;
  final String? type;
  final String? poster;
}