class Movie {
  String id;
  String title;
  String director;
  String genre;
  int year;
  String poster;
  double rating;

  Movie({
    required this.id,
    required this.title,
    required this.director,
    required this.genre,
    required this.year,
    required this.poster,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      director: json['director'],
      genre: json['genre'],
      year: json['year'],
      poster: json['poster'],
      rating: (json['rating'] as num).toDouble(),
    );
  }
}
